require 'net/http'
require 'addressable/uri'

class Api::V1::GeoController < ApplicationController
	before_filter :authenticate_user!

	GOOGLE_KEY = 'AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA'

  # GET /api/v1/geo?lat=60.109844&lon=29.946842
	def complete
		# https://maps.googleapis.com/maps/api/geocode/json?latlng=60.109844,29.946842&key=AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA
		unless params[:lat].nil? || params[:lon].nil?
			# get the nearest spot
			spot = Api::V1::Spot.order("(POW((geo_lon - #{params[:lon]}),2) + POW((geo_lat - #{params[:lat]}),2))").first
			distance = Api::V1::Report.haversine(params[:lat].to_f, params[:lon].to_f, spot.geo_lat.to_f, spot.geo_lon.to_f)

			if distance <= 1
				render json: { :spot_id => spot.id, :place => spot.city + ',' + spot.country }, status: 200
			else
				result = JSON.parse(Net::HTTP.get(Addressable::URI.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng='+params[:lat]+','+params[:lon]+'&key='+GOOGLE_KEY+'')))

				place = ''
				result['results'].each do |address|
					if address.key?('types')
						if (address['types'].include?('locality') && address['types'].include?('political')) || (address['types'].include?('administrative_area_level_2') && address['types'].include?('political'))  || (address['types'].include?('administrative_area_level_1') && address['types'].include?('political'))
							place = address['formatted_address']
							break
						end
					end
				end
				render json: { :spot_id => 0, :place => place }, status: 200
			end
		else 
			render json: { :error => 'missing required params' }, status: 401	
		end
	end
end
require 'net/http'
require 'addressable/uri'

class Api::V1::GeoController < ApplicationController
	before_filter :authenticate_user!

	GOOGLE_KEY = 'AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA'

  # GET /api/v1/geo?lat=60.109844&lon=29.946842
	def complete
		# https://maps.googleapis.com/maps/api/geocode/json?latlng=60.109844,29.946842&key=AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA
		unless params[:lat].nil? || params[:lon].nil?
			result = JSON.parse(Net::HTTP.get(Addressable::URI.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng='+params[:lat]+','+params[:lon]+'&key='+GOOGLE_KEY+'')))

			place = ''
			result['results'].each do |address|
				if address.key?('types')
					if address['types'].include?('locality') && address['types'].include?('political')
						place = address['formatted_address']
					end
				end
			end

			render json: { :place => place }, status: 200
		else 
			render json: { :error => 'missing required params' }, status: 401	
		end
	end
end
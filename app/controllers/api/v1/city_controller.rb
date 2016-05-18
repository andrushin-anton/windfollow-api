require 'net/http'
require 'addressable/uri'

class Api::V1::CityController < ApplicationController
	before_filter :authenticate_user!

	GOOGLE_KEY = 'AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA'

  # POST /api/v1/city/Piter
	def autocomplete
		# https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Paris&types=geocode&key=AIzaSyClCjEnpzYN_F27cOf3adMdqox5e4hPVXA
		result = JSON.parse(Net::HTTP.get(Addressable::URI.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+params[:input]+'&types=geocode&key='+GOOGLE_KEY+'')))

		places = []
		result['predictions'].each do |prediction|
			places << prediction['description']
		end

		render json: { :places => places }, status: 200
	end
end

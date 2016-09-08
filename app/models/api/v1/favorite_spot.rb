class Api::V1::FavoriteSpot < ActiveRecord::Base
	validates :spot_id, presence: true

	before_save :spot_exists

	private

		def spot_exists
			@spot = Api::V1::Spot.find(self.spot_id)

			if @spot.nil?
				errors.add(:base, 'Sorry, selected spot is no longer exists')
    		return false
			end
			return true
		end
end

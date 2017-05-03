class Api::V1::UserActivity < ActiveRecord::Base
    validates :user_id, presence: true, uniqueness: true
end

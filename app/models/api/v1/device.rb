class Api::V1::Device < ActiveRecord::Base
	validates :name, :inclusion => { :in => ['iphone', 'ipad'] }, presence: true
	validates :token, presence: true

	belongs_to :user
end

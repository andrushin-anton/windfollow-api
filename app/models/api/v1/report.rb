class Api::V1::Report < ActiveRecord::Base
	validates :direction, :inclusion => { :in => ['calm','e','ene','ese','n','ne','nne','nnw','nw','s','se','sse','ssw','sw','w','wnw','wsw'] }, :allow_blank => true

	has_many :report_comments
	has_many :report_likes
end

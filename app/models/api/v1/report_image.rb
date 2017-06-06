class Api::V1::ReportImage < ActiveRecord::Base
	validates :report_id, presence: true, numericality: { greater_than_or_equal_to: 1 }

	# This method associates the attribute ":image" with a file attachment
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    sevenfifty: '750x750>',
    twothousand: '2048x2048>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  belongs_to :report
  has_many :report_image_likes
  has_many :report_image_comments

  scope :recent, -> () { order('created_at DESC') }

end

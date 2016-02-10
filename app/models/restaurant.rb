class Restaurant < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	validates :name, length: { minimum: 3 }, uniqueness: true
	belongs_to :user
	has_many :reviews,
		-> { extending WithUserAssociationExtension },
		dependent: :destroy

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	def self.build_with_user(params, user)
		restaurant = new(params)
		restaurant.user = user
		restaurant
	end

	def average_rating
		return 'N/A' if reviews.none?
		reviews.inject(0) { |sum, review| sum + review.rating } / reviews.length.to_f
	end
end

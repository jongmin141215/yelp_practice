class Restaurant < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	validates :name, length: { minimum: 3 }, uniqueness: true
	belongs_to :user
	has_many :reviews

	def build_review(params, user)
		review = reviews.build(params)
		review.user = user
		review
	end

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

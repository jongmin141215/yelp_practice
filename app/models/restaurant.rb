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
end

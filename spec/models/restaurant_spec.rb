require 'spec_helper'

describe Restaurant do
	# before do
	# 	Restaurant.destroy_all
	# end
	it { is_expected.to have_many :reviews }

	it 'is not valid with a name of less than three characters' do
 		restaurant = Restaurant.new(name: 'kf')
		expect(restaurant).to have(1).error_on(:name)
		expect(restaurant).not_to be_valid
	end
	it 'is not valid unless it has a unique name' do
		restaurant_1 = Restaurant.create(name: 'KFC')
		restaurant_2 = Restaurant.new(name: 'KFC')
		expect(restaurant_2).to have(1).error_on(:name)
		expect(restaurant_2).not_to be_valid
	end

	describe '#average_rating' do

		context 'no reviews' do
			it 'returns N/A when there are no reviews' do
				restaurant = Restaurant.create(name: 'The Ivy')
				expect(restaurant.average_rating).to eq 'N/A'
			end
		end
		context '1 review' do
			it 'returns that rating' do
				restaurant = Restaurant.create(name: 'The Ivy')
				restaurant.reviews.create(rating: 4)
				expect(restaurant.average_rating).to eq 4
			end
		end
		context 'multiple reviews' do
			it 'returns the average' do
				restaurant = Restaurant.create(name: 'The Ivy')
				restaurant.reviews.create(rating: 1)
				restaurant.reviews.create(rating: 5)
				expect(restaurant.average_rating).to eq 3
			end
		end

	end
end

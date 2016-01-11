require 'spec_helper'

describe Review do 
  it { is_expected.to belong_to :restaurant }
	
	it 'is invalid if rating is more than 5' do 
		review = Review.new(thoughts: 'so so', rating: 6)
		expect(review).to have(1).error_on(:rating)
		expect(review).not_to be_valid
	end
end

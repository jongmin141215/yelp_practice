require 'spec_helper'

describe Restaurant do 
	it { is_expected.to have_many :reviews }
end

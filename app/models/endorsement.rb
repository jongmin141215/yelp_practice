class Endorsement < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :user, uniqueness: { scope: :review, message: 'has endorsed this review already' }
end

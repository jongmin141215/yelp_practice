module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    rounded_rating = rating.round
    '★' * rounded_rating + '☆' * (5 - rounded_rating)
  end
end

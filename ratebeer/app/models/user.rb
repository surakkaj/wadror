class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{4,}\z/, 
	message: "Must have 3 letters with lower- and uppercase, with numbers."}
	scope :iced, -> { where iced:true }
	scope :melted, -> { where iced:[nil, false] }

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

		def favorite_beer
			return nil if ratings.empty?
			ratings.order(score: :desc).limit(1).first.beer
		end

		def self.top(n)

			sorted_array = User.all.sort_by{ |u| -(u.ratings.count)}
			sorted_array.take(n)
		end
			
		def favorite_brewery
		    return nil if ratings.empty?
		    brewery_ratings = rated_breweries.inject([]) do |ratings, brewery|
		      ratings << {
		        brewery: brewery,
		        rating: rating_of_brewery(brewery) }
		    end

		    brewery_ratings.sort_by { |brewery| brewery[:rating] }.last[:brewery]
		  end

		  def favorite_style
		    return nil if ratings.empty?
		    style_ratings = rated_styles.inject([]) do |ratings, style|
		      ratings << {
		        style: style,
		        rating: rating_of_style(style) }
		    end

		    style_ratings.sort_by { |style| style[:rating] }.last[:style]
		  end

		  def rated_breweries
		    ratings.map{ |r| r.beer.brewery }.uniq
		  end

		  def rated_styles
		    ratings.map{ |r| r.beer.style }.uniq
		  end

		  def rating_of_brewery(brewery)
		    ratings_of_brewery = ratings.select do |r|
		      r.beer.brewery == brewery
		    end
		    ratings_of_brewery.map(&:score).sum / ratings_of_brewery.count
		  end

		  def rating_of_style(style)
		    ratings_of_style = ratings.select do |r|
		      r.beer.style == style
		    end
		    ratings_of_style.map(&:score).sum / ratings_of_style.count
		  end
	end

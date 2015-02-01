class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{3,}\z/, 
	message: "Must have 3 letters with lower- and uppercase, with numbers."}
	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	end

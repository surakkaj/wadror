class Beer < ActiveRecord::Base
	include RatingAverage
	validates :name, presence: true
	validates :style, presence: true
	belongs_to :brewery
	belongs_to :style
	has_many :ratings, dependent: :destroy
	has_many :users, through: :ratings
	has_many :raters, -> { uniq }, through: :ratings, source: :user

	
	def to_s
		"#{name} #{brewery.name}"
	end

	def self.top(n)

		sorted_array = Beer.all.sort_by{ |b| -(b.average_rating)}
		sorted_array.take(n)
	end

	def average
		return 0 if ratings.empty?
		ratings.map{ |r| r.score }.sum / ratings.count.to_f
	end
end

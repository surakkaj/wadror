class Brewery < ActiveRecord::Base
	include RatingAverage
	validates :name, presence: true
	validates :year, numericality: {greater_than_or_equal_to: 1042, 
				only_integer: true}
	validate :year_cannot_be_larger_than_current_year

	scope :active, -> { where active:true }
	scope :retired, -> { where active:[nil, false] }

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def year_cannot_be_larger_than_current_year
		if year > Time.now.year
			errors.add(:year, "A brewery cannot be founded in the future")
		end
	end

	def year
		read_attribute(:year)
	end

	def year=(value)
		write_attribute(:year, value)
	end

	def print_report
		puts self.name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def self.top(n)

		sorted_array = Brewery.all.sort_by{ |b| -(b.average_rating)}
		sorted_array.take(n)
	end

	def to_s
		return self.name 
	end


	def restart
		self.year =2015
		puts "changed year to #{year}"
	end
end

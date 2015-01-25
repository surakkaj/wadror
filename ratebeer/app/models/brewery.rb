class Brewery < ActiveRecord::Base
	include RatingAverage
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

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
	def to_s
		return self.name 
	end


	def restart
		self.year =2015
		puts "changed year to #{year}"
	end
end

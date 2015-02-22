class Style < ActiveRecord::Base

	has_many :beers
def to_s
		"#{self.style}"
			
	end

	def self.top(n)

		sorted_array = Style.all.sort_by{ |b| -(b.average_rating)}
		sorted_array.take(n)
	end
end

class Rating < ActiveRecord::Base
	belongs_to :beer

	def to_s
		print "#{self.beer.name} #{self.score} "
		puts "\n"
		
	end
end

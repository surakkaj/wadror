module RatingAverage
		def average_rating
		summa = 0;
		self.ratings.each do |rat|
			summa += rat.score
		end
		return summa / self.ratings.count
	end
end
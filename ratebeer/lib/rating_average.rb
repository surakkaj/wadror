module RatingAverage
		def average_rating
		summa = 0;
		self.ratings.each do |rat|
			summa += rat.score
		end
		if self.ratings.count == 0
			return 0
		else
		return summa / self.ratings.count
	end
	end
end
class StringCalculator
	def add(string_num)
		return 0 if string_num.empty?
		return string_num.to_i if string_num.split(",").size == 1
		return string_num.split(",").map(&:to_i).sum
	end
end

class StringCalculator
	DEFINED_SEPERATORS = [",", "\n", ";", ":"]
	def add(string_num)
		return 0 if string_num.empty?
		numbers = string_num.split(Regexp.union(DEFINED_SEPERATORS)).map(&:to_i)
		return numbers.sum
	end
end

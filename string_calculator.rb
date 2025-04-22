require 'byebug'

class StringCalculator
	DEFINED_SEPERATORS = [",", "\n", ";", ":"]
	def add(string_num)
		return 0 if string_num.empty?
		numbers = string_num.split(Regexp.union(DEFINED_SEPERATORS)).map {|num| num.empty? ? "0" : num}
		numbers.each do |num|
      raise "Invalid number: '#{num}'" unless num =~ /^\d+$/
    end
		return numbers.map(&:to_i).sum
	end
end

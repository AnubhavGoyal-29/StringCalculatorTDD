require 'byebug'

class StringCalculator
	DEFINED_SEPERATORS = [",", "\n", ";", ":"]
	def add(string_num)
		return 0 if string_num.empty?
		seperators = get_seperators(string_num)
		string_num = extract_string_num(string_num)
		numbers = string_num.split(Regexp.union(seperators)).map { |num| 
			num.empty? ? "0" : num
		}
		numbers.each do |num|
      raise "Invalid number: '#{num}'" unless num =~ /^\d+$/
    end
		return numbers.map(&:to_i).sum
	end

	def get_seperators(string_num)
	end

	def extract_string_num(string_num)
	end
end

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
		if(string_num.start_with?("//"))
			seperators_part  = string_num[2..-1].split("\n", 2).first
			seperators = seperators_part.match(/\[(.*?)\]/)
			(DEFINED_SEPERATORS <<  seperators[1]).uniq if seperators
		else
			DEFINED_SEPERATORS
		end
	end

	def extract_string_num(string_num)
		if(string_num.start_with?("//"))
			string_num[2..-1].split("\n", 2).last
		else
			string_num
		end
	end
end

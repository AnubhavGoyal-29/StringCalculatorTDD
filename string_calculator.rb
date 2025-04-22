class StringCalculator
	DEFAULT_SEPARATORS = [",", "\n"]

	def add(input)
		return 0 if input.empty?

		separators = extract_separators(input)
		numbers = extract_numbers(input, separators)

		validate_numbers(numbers)

		negative_numbers = find_negative_numbers(numbers)
		raise "negative numbers not allowed #{negative_numbers.join(', ')}" if negative_numbers.any?

		sum_valid_numbers(numbers)
	end

	private

	def extract_separators(input)
		if input.start_with?("//")
			custom_separators_part = input[2..-1].split("\n", 2).first
			custom_separators = custom_separators_part.scan(/\[(.*?)\]/).flatten
			(DEFAULT_SEPARATORS + custom_separators).uniq
		else
			DEFAULT_SEPARATORS
		end
	end

	def extract_numbers(input, separators)
		string_numbers = extract_number_string(input)
		string_numbers.split(Regexp.union(separators)).map { |num| num.empty? ? "0" : num }
	end

	def extract_number_string(input)
		input.start_with?("//") ? input[2..-1].split("\n", 2).last : input
	end

	def validate_numbers(numbers)
		numbers.each do |num|
			raise "Invalid number: '#{num}'" unless num =~ /^-?\d+$/
		end
	end

	def find_negative_numbers(numbers)
		numbers.map(&:to_i).select { |num| num < 0 }
	end

	def sum_valid_numbers(numbers)
		numbers.map(&:to_i).select { |num| num <= 1000 }.sum
	end
end


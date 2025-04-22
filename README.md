# StringCalculator

This project implements a simple string calculator that handles different types of delimiters and calculates the sum of numbers in a string.

## Features

- Handle default delimiters (`,`, `\n`)
- Custom delimiters (single and multi-character)
- Handles negative numbers and throws an error with a specific message
- Ignores numbers greater than 1000
- Supports multiple delimiters at once

## Setup

### Prerequisites

Make sure you have Ruby installed on your machine. If not, you can install Ruby from the official website: https://www.ruby-lang.org/en/documentation/installation/

Then, install the required gems:

```bash
bundle init
add gem 'rspec' in Gemfile
bundle install
```

### Running the tests

Once the setup is done, you can run all the test cases using:

```bash
bundle exec rspec
```

## Tests

### Test cases included:

- **Empty string**: Returns `0`.
- **Single number**: Returns the number itself.
- **Comma-separated numbers**: Returns the sum of numbers separated by commas.
- **Line-break-separated numbers**: Returns the sum of numbers separated by newlines.
- **Different separators**: Handles combinations of `,`, `\n`.
- **Custom separator**: Handles custom delimiters like `//[***]\n1***2`.
- **Negative numbers**: Raises an error with a message `"negative numbers not allowed -11, -2"` when negative numbers are present.
- **Numbers greater than 1000**: Ignores numbers greater than 1000.
- **Multiple delimiters**: Handles multiple delimiters like `//[***][---]\n1***2---1002`.

## Example Usage

### Code : string_calculator.rb
```ruby
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
```
### Test File: `spec/string_calculator_spec.rb`

```ruby
require_relative '../string_calculator'

RSpec.describe StringCalculator do
  it "returns 0 for an empty string" do
    calc = StringCalculator.new
    expect(calc.add("")).to eq(0)
  end

  it "returns num when there is only 1 num" do
    calc = StringCalculator.new
    expect(calc.add("1")).to eq(1)
  end

  it "returns the sum of two numbers separated by a comma" do
    calc = StringCalculator.new
    expect(calc.add("1,2")).to eq(3)
  end

  it "returns the sum of numbers separated by a newline" do
    calc = StringCalculator.new
    expect(calc.add("1\n2")).to eq(3)
  end

  it "returns the sum of numbers separated by different separators" do
    calc = StringCalculator.new
    expect(calc.add("1\n2,3\n4,5")).to eq(15)
  end

  it "returns the sum of numbers separated by custom single character separator" do
    calc = StringCalculator.new
    expect(calc.add("//[-]\n1-2")).to eq(3)
  end

  it "returns the sum of numbers separated by custom multi-character separator" do
    calc = StringCalculator.new
    expect(calc.add("//[***]\n1***2")).to eq(3)
  end

  it "raises an error when negative numbers are present in the string" do
    calc = StringCalculator.new
    expect { calc.add("//[***]\n-11***-2") }.to raise_error("negative numbers not allowed -11, -2")
  end

  it "ignores numbers bigger than 1000" do
    calc = StringCalculator.new
    expect(calc.add("//[***]\n1***2***1002")).to eq(3)
  end

  it "should handle multiple separators" do
    calc = StringCalculator.new
    expect(calc.add("//[***][---]\n1***2---1002")).to eq(3)
  end
end
```

## How it Works

1. **Default Separators**: The calculator splits the input string using the default separators `,`, `\n`.
2. **Custom Separators**: You can define a custom separator at the beginning of the string using the format `//[separator]\n[number1][separator][number2]`.
3. **Negative Numbers**: If the input string contains negative numbers, the calculator throws an error listing all negative numbers.
4. **Numbers Greater Than 1000**: Numbers greater than 1000 are ignored during the calculation.
5. **Multiple Separators**: Multiple custom separators can be used in the format `//[separator1][separator2]\n[number1][separator1][number2]`.

## Author

Anubhav Goyal


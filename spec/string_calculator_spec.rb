require_relative '../string_calculator'

RSpec.describe StringCalculator do
  it "returns 0 for an empty string" do
    calc = StringCalculator.new
    expect(calc.add("")).to eq(0)
  end

	it "return num when there is only 1 num" do
		calc = StringCalculator.new
    expect(calc.add("1")).to eq(1)
	end

	it "returns the sum of two numbers separated by a comma" do
    calc = StringCalculator.new
    expect(calc.add("1,2")).to eq(3)
  end

	it "returns the sum of numbers separated by a enter" do
    calc = StringCalculator.new
    expect(calc.add("1\n2")).to eq(3)
  end

	it "returns the sum of numbers separated by different seperators" do
    calc = StringCalculator.new
    expect(calc.add("1\n2,3\n4,5")).to eq(15)
  end

	it "returns the sum of numbers separated by custom single character seperator" do
		calc = StringCalculator.new
		expect(calc.add("//[-]\n1-2")).to eq(3)
	end

	it "returns the sum of numbers separated by custom multi char character seperator" do
    calc = StringCalculator.new
    expect(calc.add("//[***]\n1***2")).to eq(3)
  end

	it "raise error when negative numbers are present in the string" do
		calc = StringCalculator.new
		expect { calc.add("//[***]\n-11***-2") }.to raise_error("negative numbers not allowed -11, -2")
	end

	it "numbers bigger than 1000 should be ignored" do
    calc = StringCalculator.new
    expect(calc.add("//[***]\n1***2***1002")).to eq(3)
  end 

	it "should handle multiple seperators" do
    calc = StringCalculator.new
    expect(calc.add("//[***][---]\n1***2---1002")).to eq(3)
  end
end

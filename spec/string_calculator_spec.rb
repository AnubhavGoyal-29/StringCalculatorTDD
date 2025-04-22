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
end


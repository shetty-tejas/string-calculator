require "minitest/autorun"
require_relative "./string_calculator"

class TestStringCalculator < Minitest::Test
  def setup
    @described_class = StringCalculator
  end

  def test_argument_should_be_string
    assert_raises(ArgumentError) { @described_class.add(1) }
    assert_equal @described_class.add(""), 0
  end
end

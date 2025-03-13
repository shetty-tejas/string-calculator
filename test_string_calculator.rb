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

  def test_argument_has_one_integer
    assert_equal @described_class.add("0"), 0
    assert_equal @described_class.add("1"), 1
  end

  def test_argument_has_two_integers
    assert_equal @described_class.add("0,1"), 1
    assert_equal @described_class.add("1,2"), 3
  end

  def test_argument_has_hundred_integers
    assert_equal @described_class.add((1..100).to_a.join(',')), 5050
  end

  def test_argument_has_new_lines_and_still_works
    assert_equal @described_class.add("0\n,1,2,3\n\n4"), 10
    assert_equal @described_class.add("1\n2\n3\n"), 6
  end
end

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

  def test_argument_has_custom_delimiters
    assert_equal @described_class.add("//;\n0;1\n2;3;4\n"), 10
    assert_equal @described_class.add("//***\n0***1***2***3***\n4***\n***5"), 15
  end

  def test_argument_cannot_have_negative_integers
    assert_raises(ArgumentError, "negative numbers not allowed -1,-2,-3") { @described_class.add("0,-1\n-2\n,-3,4,5") }
    assert_raises(ArgumentError, "negative numbers not allowed -1") { @described_class.add("//;\n0;-1\n2;3;4\n") }
    assert_raises(ArgumentError, "negative numbers not allowed -1,-4,-5") { @described_class.add("//***\n0***-1***2***3***\n-4***\n***-5") }
  end

  def test_argument_has_multiple_delimiters
    assert_raises(ArgumentError, "unidentified delimiters found") { @described_class.add("1,2+3") }
    assert_raises(ArgumentError, "unidentified delimiters found") { @described_class.add("//;\n0,1;2;3;4") }
    assert_raises(ArgumentError, "unidentified delimiters found") { @described_class.add("//***\n0***-1***2*&*3***\n-4***-5") }
  end
end

module StringCalculator
  class << self
    def add(str)
      raise ArgumentError, "argument should be a string" unless str.is_a?(String)

      numbers_to_add = handle_input(str)

      return numbers_to_add.sum
    end

    private

    def handle_input(str)
      numbers = str.split(/\n|,/).map(&:to_i)
      return [0] if numbers.size.zero?

      return numbers
    end
  end
end

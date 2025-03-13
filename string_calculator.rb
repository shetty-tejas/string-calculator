module StringCalculator
  class << self
    def add(str)
      raise ArgumentError, "argument should be a string" unless str.is_a?(String)

      return 0
    end
  end
end

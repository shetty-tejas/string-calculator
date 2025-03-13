module StringCalculator
  INPUT_REGEX =  /\A(?:\/\/(?<delimiter>[^\n]+)\n)?(?<numbers>.*)\z/m

  class << self
    def add(str)
      raise ArgumentError, "argument should be a string" unless str.is_a?(String)

      numbers_to_add(str).sum
    end

    private

    def numbers_to_add(str)
      result = str.match(INPUT_REGEX)
      return [0] unless result

      separators = ["\n", (result[:delimiter] || ',')].map { |d| Regexp.escape(d) }.join('|')
     
      numbers = result[:numbers].split(/#{separators}/).reject(&:empty?)

      unless numbers.all? { |n| n.match?(/\A-?\d+\z/) }
        raise ArgumentError, "unidentified delimiters found"
      end

      numbers = numbers.map(&:to_i)

      unless (negatives = numbers.select(&:negative?)).length.zero?
        raise ArgumentError, "negative numbers not allowed #{negatives.join(',')}"
      end  
      
      return [0] if numbers.size.zero?

      numbers
    end
  end
end

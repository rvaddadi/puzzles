module Holes

  class Cli
    def initialize(calculator = Calculator.new)
      @calculator = calculator
    end

    def process(input)
      format(calculate(parse(input)))
    end

    def parse(input)
      input.split(':')[1].split(';').reject { |word| word.strip.empty? }
    end

    def calculate(words)
      words.map { |word| @calculator.calculate(word) }
    end

    def format(counts)
      counts.map(&:to_s).join(';')
    end
  end
end

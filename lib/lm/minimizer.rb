# frozen_string_literal: true

module Lm
  class Degenerate
    def initialize(val)
      @val = val
    end

    def to_s(_ = nil)
      @val.to_s
    end
  end

  class Minimizer
    def initialize(output_str)
      @output_str = output_str
    end

    def output_string
      OutputString.new(@output_str)
    end

    def canonical
      return degenerate if degenerate?

      output_string.sop
    end

    def qcm
      QuineMcCluskey.new(canonical.implicants)
    end

    def implicants
      qcm.prime_implicants
    end

    def pm
      Petrick.new(implicants)
    end

    def pos
      POS.new(pm.string122)
    end

    def reduced_sum
      sum = pos.apply_factorize.expand
      loop do
        newsum = sum.reduce
        return newsum if sum.to_s.length == newsum.to_s.length

        sum = newsum
      end
      sum
    end

    def calculator
      String122ResultSelector.new(implicants, reduced_sum)
    end

    def variation
      @variation ||= @output_str.split("").uniq
    end

    # degenerate case
    def degenerate?
      variation.length == 1
    end

    def degenerate
      Degenerate.new(variation.first)
    end

    def shortest
      return degenerate if degenerate?

      calculator.shortest
    end

    def inputlen
      output_string.bitcount
    end

    def evaluate(input)
      return degenerate.to_s.to_i if degenerate?

      BinFunc.new(shortest).evaluate(input)
    end

    def canonical_evaluate(input)
      return degenerate.to_s.to_i if degenerate?

      BinFunc.new(output_string.sop).evaluate(input)
    end
  end
end

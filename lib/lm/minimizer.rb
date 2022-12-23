# frozen_string_literal: true

module Lm
  class Degenerate
    def initialize(val)
      @val = val
    end

    def to_s(_=nil)
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
      if degenerate?
        return degenerate
      end
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
      pos.expand.reduce
    end

    def calculator
      String122ResultSelector.new(implicants, reduced_sum)
    end

    def variation
      @variation ||= @output_str.split('').uniq
    end

    # degenerate case
    def degenerate?
      variation.length == 1
    end

    def degenerate
      Degenerate.new(variation.first)
    end

    def shortest
      if degenerate?
        return degenerate
      end
      calculator.shortest
    end

    def evaluate(input)
      BinFunc.new(shortest).evaluate(input)
    end

    def canonical_evaluate(input)
      BinFunc.new(output_string.sop).evaluate(input)
    end
  end
end

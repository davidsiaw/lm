# frozen_string_literal: true

module Lm
  class Minimizer
    def initialize(output_str)
      @output_str = output_str
    end

    def output_string
      OutputString.new(@output_str)
    end

    def canonical
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

    def shortest
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

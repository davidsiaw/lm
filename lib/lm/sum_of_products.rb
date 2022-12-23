# frozen_string_literal: true

module Lm
  class SumOfProducts
    attr_reader :arr

    def initialize(arr = [])
      @arr = arr
    end

    def <<(value)
      insert(value)
    end

    def insert(product)
      @arr << product
    end

    def implicants
      result = {}
      @arr.each do |x|
        result[x.str.to_i(2).to_s] = x.str
      end
      ImplicantChart.new(result, length: @arr.first.str.length)
    end

    def to_s(v = nil)
      joiner = "+"
      joiner = " | " if v == :verilog || (v.is_a?(Hash) && v[:verilog])
      @arr.map { |x| x.to_s(v) }.join(joiner)
    end
  end
end

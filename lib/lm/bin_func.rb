# frozen_string_literal: true

module Lm
  class BinFunc
    def initialize(products)
      @products = products.arr
    end

    def inputlen
      @products.first.vars.count
    end

    def max
      (1 << inputlen) - 1
    end

    def apply(product, bitstr)
      raise "len mismatch" if bitstr.length != product.vars.length

      result = 1

      inputlen.times do |x|
        next if product.vars[x].invalid?

        val = bitstr[x].to_i

        val = ~val if product.vars[x].value == "0"

        result &= val
      end

      result
    end

    def evaluate(num)
      raise "number too large" if num > max

      bitstr = num.to_s(2).rjust(inputlen, "0")

      result = 0
      @products.each do |product|
        result |= apply(product, bitstr)
      end

      result
    end
  end
end

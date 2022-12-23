# frozen_string_literal: true

module Lm
  class OutputString
    def initialize(str)
      @str = str

      if @str.length < 2
        @str = @str.rjust(2, '0')
      end
    end

    def bitcount
      [Math.log(@str.length, 2).ceil, 1].max
    end

    def sop
      res = SumOfProducts.new
      @str.length.times do |x|
        bitbreak = x.to_s(2).rjust(bitcount, "0")
        next if @str[x] == "0"

        prod = Product.new(bitbreak)
        res << prod
      end

      res
    end

    def to_s(v = nil)
      sop.to_s(v)
    end
  end
end

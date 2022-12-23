# frozen_string_literal: true

module Lm
  class Product
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def vars
      @str.split("").each_with_index.map do |x, i|
        Variable.new(x, i)
      end
    end

    def to_s(v = nil)
      joiner = ""

      joiner = " & " if v == :verilog || (v.is_a?(Hash) && v[:verilog])
      vars.map { |x| x.to_s(v) }.compact.join(joiner)
    end
  end
end

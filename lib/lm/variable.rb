# frozen_string_literal: true

module Lm
  class Variable
    attr_reader :value

    def initialize(value, pos)
      @value = value
      @pos = pos
    end

    def invalid?
      @value != "1" && @value != "0"
    end

    def notop
      @value == "0" ? "~" : ""
    end

    def bar
      @value == "0" ? "\u0305" : ""
    end

    def subscript
      result = ""

      @pos.to_s.split("").each do |digit|
        result += (0x2080 + digit.to_i).chr("UTF-8")
      end

      result
    end

    LETTERS = %(ABCDEFGHJKLMNPQRSTUVWXYZ)

    def to_abc(letters = LETTERS)
      return to_x if @pos >= letters.length
      return "" if invalid?

      letters[@pos] + bar
    end

    def to_x(input = "X")
      return "" if invalid?

      input.to_s + bar + subscript
    end

    def to_verilog(letter)
      return nil if invalid?

      "#{notop}#{letter}[#{@pos}]"
    end

    def to_s(input = nil)
      input ||= LETTERS
      if input.is_a?(String) && input.end_with?("#")
        to_x(input[0])
      elsif input == :verilog
        to_verilog(x)
      elsif input.is_a?(Hash) && input[:verilog]
        to_verilog(input[:verilog])
      else
        to_abc(input)
      end
    end
  end
end

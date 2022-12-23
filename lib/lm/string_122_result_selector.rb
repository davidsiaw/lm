# frozen_string_literal: true

module Lm
  class String122ResultSelector
    def initialize(pm, sum)
      @pm = pm
      @sum = sum
    end

    def chart
      @chart ||= @pm.soplist.map do |k, v|
        {
          columns: k,
          product: v
        }
      end
    end

    def sum_list
      @sum.str.split("+").map do |term|
        term.split("").map do |str122|
          idx = str122.ord - 48
          chart[idx][:product]
        end
      end
    end

    def sum_strings
      sum_list.each_with_index.map { |x, i| { str: x.join("+"), idx: i } }
    end

    def shortest
      idx = sum_strings.min_by { |x| x[:str].length }[:idx]
      SumOfProducts.new(sum_list[idx])
    end
  end
end

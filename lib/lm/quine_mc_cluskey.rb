# frozen_string_literal: true

module Lm
  class QuineMcCluskey
    def initialize(chart)
      @chart = chart
    end

    def prime_implicants
      curchart = @chart
      loop do
        newchart = curchart.reduced
        break if newchart.keys == curchart.keys

        curchart = newchart
      end
      curchart
    end
  end
end

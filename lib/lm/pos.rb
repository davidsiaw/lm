# frozen_string_literal: true

module Lm
  # definitions
  # A = factor
  # AB = term
  # AB+C = sum
  # (AB + C)(D + E) = product of sums
  # AB+C,D+E

  class POS
    def initialize(str)
      @str = str
    end

    def sum_array
      @sum_array ||= @str.split(",")
    end

    def termhash
      @termhash ||= begin
        res = {}
        sum_array.each do |sum|
          terms = sum.split("+", 2)
          terms.each do |term|
            res[term] ||= Set.new
            terms.each do |x|
              next if x == term

              res[term] << x
            end
          end
        end
        res
      end
    end

    def apply_factorize
      newarray = []
      seenkeys = Set.new

      termhash.each do |key, value|
        next if seenkeys.include?(([key] + value.to_a).sort.join("|").to_s)

        seenkeys << ([key] + value.to_a).sort.join("|")
        newarray << "#{key}+#{value.map { |x| Sum.new(x) }.inject(:multiply)}"
      end

      POS.new(newarray.join(","))
    end

    # return SOP
    def expand
      # puts "EXPAND"
      arr = sum_array

      loop do
        break if arr.length == 1

        aterms = arr[0].split("+")
        bterms = arr[1].split("+")

        newterms = aterms.product(bterms).map do |x|
          x.join("").split("").uniq.join("")
        end

        newsum = newterms.join("+")

        arr = [newsum] + arr[2..]
        # p arr
      end

      Sum.new(arr.first)
    end
  end
end

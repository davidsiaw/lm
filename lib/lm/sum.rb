# frozen_string_literal: true

module Lm
  class Sum
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def multiply(other_sum)
      raise 'Not a sum' unless other_sum.is_a? Sum

      newarr = product_list.map{|x| x.to_a}.product(other_sum.product_list.map{|x| x.to_a})

      newstr = newarr.map{|x| x.join('')}.join('+')
      Sum.new(newstr)
    end

    def product_list
      @str.split("+").map { |x| Set.new(x.split("")) }
    end

    def by_length
      product_list.sort_by{|x| x.length}
    end

    def reduce
      res = []
      arr = by_length

      loop do
        cur = arr.shift

        newarr = []
        arr.each do |x|
          # remove supersets (X + XY = X)
          next if cur.subset?(x)

          newarr << x
        end
        res << cur
        arr = newarr

        break if arr.length.zero?
      end

      Sum.new(res.map { |x| x.to_a.join("") }.join("+"))
    end

    def to_s
      @str
    end
  end
end

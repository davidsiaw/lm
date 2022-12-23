# frozen_string_literal: true

module Lm
  class ImplicantChart
    def initialize(chart, length:, step: 0)
      @chart = chart
      @step = step
      @length = length
    end

    def buckets
      @buckets ||= begin
        rr = {}
        @chart.each do |k, v|
          ones = v.count("1")
          rr[ones] ||= {}
          rr[ones][k] = v
        end
        # p rr
        rr
      end
    end

    def keys
      Set.new(@chart.keys)
    end

    def reduced
      rr = {}
      touched = Set.new
      @length.times do |x|
        next if buckets[x].nil?
        next if buckets[x + 1].nil?

        buckets[x].each do |num, pattern|
          buckets[x + 1].each do |num2, pattern2|
            diffcount = 0
            last = 0
            @length.times do |col|
              if pattern[col] == "-" && pattern2[col] != "-" ||
                 pattern2[col] == "-" && pattern[col] != "-"
                diffcount += 2
                last = col
              end
              next unless pattern[col] == "1" && pattern2[col] == "0" ||
                          pattern2[col] == "1" && pattern[col] == "0"

              diffcount += 1
              last = col
            end
            next unless diffcount == 1

            str = pattern.dup
            str[last] = "-"
            rr["#{num},#{num2}".split(",").sort.join(",").to_str] = str
            touched << num.to_s
            touched << num2.to_s
          end
        end
      end

      @chart.each do |k, v|
        next if touched.include? k

        rr[k] = v
      end
      ImplicantChart.new(rr, step: @step + 1, length: @length)
    end

    def soplist
      rr = {}
      @chart.each do |k, v|
        rr[k] = Product.new(v)
      end
      rr
    end

    def variables
      @variables ||= begin
        vars = Set.new
        @chart.each_key do |x|
          x.split(",").each do |name|
            vars << name
          end
        end
        vars
      end
    end
  end
end

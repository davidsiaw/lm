# frozen_string_literal: true

module Lm
  class Petrick
    def initialize(chart)
      @chart = chart
    end

    def grouplist
      @grouplist ||= @chart.keys
    end

    # factors from the petrick table
    def factors
      factorlist = []
      uncovered_columns.each do |var|
        factor = []
        grouplist.each_with_index do |group, idx|
          vlist = Set.new(group.split(","))
          factor << [idx] if vlist.include?(var)
        end

        factorlist << factor
      end
      factorlist + essential_rows.map { |x| [[x]] }
    end

    def essential_columns
      @essential_columns ||= begin
        varcounts = {}
        grouplist.each_with_index do |group, _idx|
          group.split(",").each do |v|
            varcounts[v] ||= 0
            varcounts[v] += 1
          end
        end
        varcounts.select { |_k, v| v == 1 }.to_h.keys
      end
    end

    def essential_rows
      @essential_rows ||= begin
        rows = []

        essential_columns.each do |x|
          grouplist.each_with_index do |group, idx|
            vars = Set.new(group.split(","))
            if vars.include?(x)
              rows << idx
              break
            end
          end
        end
        rows
      end
    end

    def uncovered_columns
      @uncovered_columns ||= begin
        touched = Set.new
        essential_rows.each do |idx|
          touched += grouplist.to_a[idx].split(",")
        end

        @chart.variables - touched
      end
    end

    def string122
      factors.map { |sums| sums.map { |prducts| prducts.map { |x| (x.ord + 48).chr }.join("") }.join("+") }.join(",")
    end
  end
end

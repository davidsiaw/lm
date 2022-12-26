# frozen_string_literal: true

RSpec.describe Lm::Sum do
  describe "#multiply" do
    it "does simple multiply" do
      sop1 = Lm::Sum.new("1")
      sop2 = Lm::Sum.new("2")

      expect(sop1.multiply(sop2).product_list).to eq [Set.new(%w[1 2])]
    end

    it "does distribute multiply" do
      sop1 = Lm::Sum.new("1")
      sop2 = Lm::Sum.new("2+3")

      expect(sop1.multiply(sop2).product_list).to eq [Set.new(%w[1 2]), Set.new(%w[1 3])]
    end

    it "does fully multiply" do
      sop1 = Lm::Sum.new("1+4")
      sop2 = Lm::Sum.new("2+3")

      expect(sop1.multiply(sop2).product_list).to eq [
        Set.new(%w[1 2]), Set.new(%w[1 3]),
        Set.new(%w[4 2]), Set.new(%w[4 3])
      ]
    end

    it "does fully multiply with more" do
      sop1 = Lm::Sum.new("1+4")
      sop2 = Lm::Sum.new("2+3+5")

      expect(sop1.multiply(sop2).product_list).to eq [
        Set.new(%w[1 2]), Set.new(%w[1 3]), Set.new(%w[1 5]),
        Set.new(%w[4 2]), Set.new(%w[4 3]), Set.new(%w[4 5])
      ]
    end

    it "does fully multiply inner" do
      sop1 = Lm::Sum.new("1+45")
      sop2 = Lm::Sum.new("2+3")

      expect(sop1.multiply(sop2).product_list).to eq [
        Set.new(%w[1 2]), Set.new(%w[1 3]),
        Set.new(%w[4 5 2]), Set.new(%w[4 5 3])
      ]
    end
  end

  describe "#to_s" do
    it "does the right thing" do
      sop1 = Lm::Sum.new("1+45")
      sop2 = Lm::Sum.new("2+3").multiply(sop1)
      expect(sop2.to_s).to eq "21+245+31+345"
    end
  end
end

# frozen_string_literal: true

RSpec.describe Lm do
  it "has a version number" do
    expect(Lm::VERSION).not_to be nil
  end

  it "returns expected xor" do
    min = Lm::Minimizer.new("0110")
    expect(min.evaluate(0)).to eq 0
    expect(min.evaluate(1)).to eq 1
    expect(min.evaluate(2)).to eq 1
    expect(min.evaluate(3)).to eq 0
    expect(min.shortest.to_s(verilog: "a")).to eq "~a[0] & a[1] | a[0] & ~a[1]"
  end

  it "returns expected and" do
    min = Lm::Minimizer.new("0001")
    expect(min.evaluate(0)).to eq 0
    expect(min.evaluate(1)).to eq 0
    expect(min.evaluate(2)).to eq 0
    expect(min.evaluate(3)).to eq 1
    expect(min.shortest.to_s(verilog: "a")).to eq "a[0] & a[1]"
  end

  it "returns expected or" do
    min = Lm::Minimizer.new("0111")
    expect(min.shortest.to_s(verilog: "a")).to eq "a[1] | a[0]"
  end

  it "returns expected nand" do
    min = Lm::Minimizer.new("1110")
    expect(min.shortest.to_s(verilog: "a")).to eq "~a[0] | ~a[1]"
  end

  it "return canonical" do
    min = Lm::Minimizer.new("1110")
    expect(min.canonical.to_s(verilog: "a")).to eq "~a[0] & ~a[1] | ~a[0] & a[1] | a[0] & ~a[1]"
  end

  it "returns degenerate case 0" do
    min = Lm::Minimizer.new("0")
    expect(min.shortest.to_s(verilog: "a")).to eq "0"
  end

  it "returns degenerate case 00000" do
    min = Lm::Minimizer.new("00000")
    expect(min.shortest.to_s(verilog: "a")).to eq "0"
  end

  it "returns degenerate case 11" do
    min = Lm::Minimizer.new("11")
    expect(min.shortest.to_s(verilog: "a")).to eq "1"
  end

  it "returns degenerate case 1111111" do
    min = Lm::Minimizer.new("1111111")
    expect(min.shortest.to_s(verilog: "a")).to eq "1"
  end
end

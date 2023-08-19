# frozen_string_literal: true

RSpec.describe Tursodb::LocationApi::Resources::Location do
  let(:location) { described_class.new(symbol: "symbol", name: "sample-location") }

  describe "#initialize" do
    it "initializes with symbol and name" do
      expect(location.symbol).to eq("symbol")
      expect(location.name).to eq("sample-location")
    end
  end
end

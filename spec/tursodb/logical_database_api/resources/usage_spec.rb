# frozen_string_literal: true

RSpec.describe Tursodb::LogicalDatabaseApi::Resources::Usage do
  let(:usage) { described_class.new(rows_read: "100", rows_written: "100", storage_bytes: "400") }

  describe "#initialize" do
    it "initializes with rows_read, row_written and storgae_bytes" do
      expect(usage.rows_read).to eq("100")
      expect(usage.rows_written).to eq("100")
      expect(usage.storage_bytes).to eq("400")
    end
  end
end

# frozen_string_literal: true

RSpec.describe Tursodb::LogicalDatabaseApi::Resources::LogicalDatabase do
  let(:logical_database) do
    described_class.new(
      name: "TestDB",
      hostname: "testdb.turso.tech",
      issued_cert_limit: 100,
      issued_cert_count: 50,
      db_id: "12345-uuid",
      regions: %w[us-west us-east],
      primary_region: "us-west",
      type: "logical"
    )
  end

  describe "#initialize" do
    it "initializes with correct attributes" do
      expect(logical_database.name).to eq("TestDB")
      expect(logical_database.hostname).to eq("testdb.turso.tech")
      expect(logical_database.issued_cert_limit).to eq(100)
      expect(logical_database.issued_cert_count).to eq(50)
      expect(logical_database.db_id).to eq("12345-uuid")
      expect(logical_database.regions).to eq(%w[us-west us-east])
      expect(logical_database.primary_region).to eq("us-west")
      expect(logical_database.type).to eq("logical")
    end
  end
end

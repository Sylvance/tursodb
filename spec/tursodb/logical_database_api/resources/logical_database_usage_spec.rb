# frozen_string_literal: true

RSpec.describe Tursodb::LogicalDatabaseApi::Resources::LogicalDatabaseUsage do
  let(:logical_database_usage) do
    described_class.new(
      uuid: "12345-uuid",
      instances: %w[instance1 instance2]
    )
  end

  describe "#initialize" do
    it "initializes with correct attributes" do
      expect(logical_database_usage.uuid).to eq("12345-uuid")
      expect(logical_database_usage.instances).to eq(%w[instance1 instance2])
    end
  end
end

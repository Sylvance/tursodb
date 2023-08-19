# frozen_string_literal: true

RSpec.describe Tursodb::LogicalDatabaseApi::Resources::DatabaseInstanceUsage do
  let(:usage) do
    Tursodb::LogicalDatabaseApi::Resources::Usage.new(rows_read: 1000, rows_written: 500, storage_bytes: 2000)
  end
  let(:database_instance_usage) { described_class.new(uuid: "12345-uuid", usage: usage) }

  it "initializes with correct attributes" do
    expect(database_instance_usage.uuid).to eq("12345-uuid")
    expect(database_instance_usage.usage).to eq(usage)
  end
end

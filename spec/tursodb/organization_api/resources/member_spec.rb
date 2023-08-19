# frozen_string_literal: true

RSpec.describe Tursodb::OrganizationApi::Resources::Member do
  let(:member) { described_class.new(role: "role", username: "sample-member") }

  describe "#initialize" do
    it "initializes with role and username" do
      expect(member.role).to eq("role")
      expect(member.username).to eq("sample-member")
    end
  end
end

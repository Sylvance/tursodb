# frozen_string_literal: true

RSpec.describe Tursodb::AuthenticationApi::Resources::PlatformApiToken do
  let(:token) { described_class.new(id: "12345", name: "sample-token", token: "token-string") }

  describe "#initialize" do
    it "initializes with id, name, and token" do
      expect(token.id).to eq("12345")
      expect(token.name).to eq("sample-token")
      expect(token.token).to eq("token-string")
    end
  end
end

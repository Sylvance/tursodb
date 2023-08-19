# frozen_string_literal: true

RSpec.describe Tursodb::AuthenticationApi::Resources::ValidateTokenExpiry do
  let(:token) { described_class.new(expiry: "12345", token: "token-string") }

  describe "#initialize" do
    it "initializes with id, name, and token" do
      expect(token.expiry).to eq("12345")
      expect(token.token).to eq("token-string")
    end
  end
end

# frozen_string_literal: true

RSpec.describe Tursodb::OrganizationApi::Resources::Organization do
  let(:organization) { described_class.new(name: "name", slug: "slug", type: "type") }

  describe "#initialize" do
    it "initializes with name, slug and type" do
      expect(organization.name).to eq("name")
      expect(organization.slug).to eq("slug")
      expect(organization.type).to eq("type")
    end
  end
end

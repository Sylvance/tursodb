# frozen_string_literal: true

RSpec.describe Tursodb::OrganizationApi::GetAllOrganizationMembers do
  let(:config) { Tursodb::Configuration.new }
  let(:api_caller) { described_class.new(config) }

  before do
    config.authenticate_with_token("sample-token")
  end

  describe "#call" do
    context "when the API call is successful" do
      let(:body) do
        {
          members: [
            {
              role: "owner",
              username: "MyGitHubName"
            },
            {
              role: "member",
              username: "OthersGitHubName"
            }
          ]
        }
      end

      before do
        stub_request(:get, "#{config.base_url}/v1/organizations/organization_slug/members")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: 200, body: body.to_json)
      end

      it "returns a Result object with tokens" do
        results = api_caller.call("organization_slug")
        expect(results).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::Result)
        expect(results.members).to be_an(Array)
        expect(results.members.first.username).to eq("MyGitHubName")
        expect(results.members.first.role).to eq("owner")
      end
    end

    context "when the API call fails" do
      let(:body) do
        { error: "Some Error" }
      end

      before do
        stub_request(:get, "#{config.base_url}/v1/organizations/organization_slug/members")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: status, body: body.to_json)
      end

      context "when status is 401" do
        let(:status) { 401 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call("organization_slug")
          expect(error_response).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::UNAUTHORIZED_ERROR_MESSAGE)
        end
      end

      context "when status is 402" do
        let(:status) { 402 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call("organization_slug")
          expect(error_response).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::PAYMENT_REQUIRED_ERROR_MESSAGE)
        end
      end

      context "when status is 409" do
        let(:status) { 409 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call("organization_slug")
          expect(error_response).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::RESOURCE_CONFLICT_ERROR_MESSAGE)
        end
      end

      context "when status is 500" do
        let(:status) { 500 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call("organization_slug")
          expect(error_response).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::SERVER_ERROR_MESSAGE)
        end
      end

      context "when status is 404" do
        let(:status) { 404 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call("organization_slug")
          expect(error_response).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::UNKNOWN_ERROR_MESSAGE)
        end
      end
    end

    context "when the API call block raises an error" do
      let(:error) { StandardError.new(message) }
      let(:message) { "Some error" }
      let(:body) do
        {
          members: [
            {
              role: "owner",
              username: "MyGitHubName"
            },
            {
              role: "member",
              username: "OthersGitHubName"
            }
          ]
        }
      end

      before do
        allow(Net::HTTP).to receive(:start).and_raise(error)
        stub_request(:get, "#{config.base_url}/v1/organizations/organization_slug/members")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: 200, body: body.to_json)
      end

      it "returns an ErrorResponse object with an error message" do
        results = api_caller.call("organization_slug")
        expect(results).to be_a(Tursodb::OrganizationApi::GetAllOrganizationMembers::ErrorResponse)
        expect(results.message).to eq(message)
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe Tursodb::LocationApi::GetAllSupportedLocations do
  let(:config) { Tursodb::Configuration.new }
  let(:api_caller) { described_class.new(config) }
  let(:body) do
    {
      locations: {
        ams: "Amsterdam, Netherlands",
        arn: "Stockholm, Sweden",
        bog: "Bogotá, Colombia",
        bos: "Boston, Massachusetts (US)",
        cdg: "Paris, France",
        den: "Denver, Colorado (US)",
        dfw: "Dallas, Texas (US)",
        ewr: "Secaucus, NJ (US)",
        fra: "Frankfurt, Germany",
        gdl: "Guadalajara, Mexico",
        gig: "Rio de Janeiro, Brazil",
        gru: "São Paulo, Brazil",
        hkg: "Hong Kong, Hong Kong",
        iad: "Ashburn, Virginia (US)",
        jnb: "Johannesburg, South Africa",
        lax: "Los Angeles, California (US)",
        lhr: "London, United Kingdom",
        mad: "Madrid, Spain",
        mia: "Miami, Florida (US)",
        nrt: "Tokyo, Japan",
        ord: "Chicago, Illinois (US)",
        otp: "Bucharest, Romania",
        qro: "Querétaro, Mexico",
        scl: "Santiago, Chile",
        sea: "Seattle, Washington (US)",
        sin: "Singapore, Singapore",
        sjc: "San Jose, California (US)",
        syd: "Sydney, Australia"
      }
    }
  end

  before do
    config.authenticate_with_token("sample-token")
  end

  describe "#call" do
    context "when the API call is successful" do
      before do
        stub_request(:get, "#{config.base_url}/v1/locations")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: 200, body: body.to_json)
      end

      it "returns a Result object with tokens" do
        results = api_caller.call
        expect(results).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::Result)
        expect(results.locations).to be_an(Array)
        expect(results.locations.first.name).to eq("Amsterdam, Netherlands")
        expect(results.locations.first.symbol).to eq("ams")
      end
    end

    context "when the API call fails" do
      let(:body) do
        { error: "Some Error" }
      end

      before do
        stub_request(:get, "#{config.base_url}/v1/locations")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: status, body: body.to_json)
      end

      context "when status is 401" do
        let(:status) { 401 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call
          expect(error_response).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::UNAUTHORIZED_ERROR_MESSAGE)
        end
      end

      context "when status is 402" do
        let(:status) { 402 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call
          expect(error_response).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::PAYMENT_REQUIRED_ERROR_MESSAGE)
        end
      end

      context "when status is 409" do
        let(:status) { 409 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call
          expect(error_response).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::RESOURCE_CONFLICT_ERROR_MESSAGE)
        end
      end

      context "when status is 500" do
        let(:status) { 500 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call
          expect(error_response).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::SERVER_ERROR_MESSAGE)
        end
      end

      context "when status is 404" do
        let(:status) { 404 }

        it "returns an ErrorResponse object with an error message" do
          error_response = api_caller.call
          expect(error_response).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
          expect(error_response.message).to eq(Tursodb::Errors::UNKNOWN_ERROR_MESSAGE)
        end
      end
    end

    context "when the API call block raises an error" do
      let(:error) { StandardError.new(message) }
      let(:message) { "Some error" }

      before do
        allow(Net::HTTP).to receive(:start).and_raise(error)
        stub_request(:get, "#{config.base_url}/v1/locations")
          .with(headers: { "Authorization" => "Bearer #{config.token}" })
          .to_return(status: 200, body: body.to_json)
      end

      it "returns an ErrorResponse object with an error message" do
        results = api_caller.call
        expect(results).to be_a(Tursodb::LocationApi::GetAllSupportedLocations::ErrorResponse)
        expect(results.message).to eq(message)
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe Tursodb::Configuration do
  let(:config) { Tursodb::Configuration.new }

  describe '#initialize' do
    it 'sets the default base_url' do
      expect(config.base_url).to eq('https://api.turso.tech')
    end

    it 'does not set a token by default' do
      expect(config.token).to be_nil
    end
  end

  describe '#authenticate_with_token' do
    it 'sets the token' do
      config.authenticate_with_token('sample-token')
      expect(config.token).to eq('sample-token')
    end
  end

  describe '#authenticated?' do
    context 'when token is not set' do
      it 'returns false' do
        expect(config.authenticated?).to be_falsey
      end
    end

    context 'when token is set' do
      before do
        config.authenticate_with_token('sample-token')
      end

      it 'returns true' do
        expect(config.authenticated?).to be_truthy
      end
    end
  end
end

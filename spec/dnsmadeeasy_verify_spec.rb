require 'Dnsmadeeasy_verify'

RSpec::Matchers.define :contains_domain do |expected|
  match do |actual|
    actual % expected == 0
  end
end

RSpec.describe Dnsmadeeasy_verify do

  before(:each) do
    Dnsmadeeasy_verify.configure do |config|
      config.dnsmadeeasy_api_key = ENV["DNSMADEEASY_API_KEY"]
      config.dnsmadeeasy_api_secret = ENV["DNSMADEEASY_SECRET"]
    end
  end

  describe "#list_domains" do

    context 'when api creds are valid' do

      let(:resource) { Dnsmadeeasy_verify.list_domains }

      it 'contains an expected domain' do
        expect(resource[ENV["EXPECTED_DOMAIN"]].name).to eq(ENV["EXPECTED_DOMAIN"])
      end

      it 'does not contain an unexpected domain' do
        expect(resource[ENV["UNEXPECTED_DOMAIN"]]).to eq(nil)
      end

    end

  end

end

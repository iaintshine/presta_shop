require "spec_helper"

describe PrestaShop::Configuration do
	context "default configuration" do
		let(:conf) { PrestaShop::Configuration.new }

		it "raise error on validation" do
			expect{ conf.validate! }.to raise_error(PrestaShop::UninitializedError)
		end

		it "has nil url" do
			expect(conf.api_url).to be_false
		end

		it "has nil key" do
			expect(conf.api_key).to be_false
		end
	end

	context "invalid configuration" do
		let(:conf) { PrestaShop::Configuration.new(:api_url => "http://some/resource")}

		it "raise error on validation" do
			expect{ conf.validate! }.to raise_error(PrestaShop::UninitializedError)
		end
	end

	context "valid configuration" do
		let(:conf) { PrestaShop::Configuration.new(:api_url => "http://presta/shop", :api_key => "PRESTASH00PAPIKEY") }

		it "returns valid api url when no api subresource" do
			c = PrestaShop::Configuration.new(:api_url => "http://presta/shop", :api_key => "PRESTASH00PAPIKEY" )

			expect(c.api_url).to eq("http://presta/shop/api/")
		end

		it "returns valid api url when slash and no api" do
			c = PrestaShop::Configuration.new(:api_url => "http://presta/shop/", :api_key => "PRESTASH00PAPIKEY" )

			expect(c.api_url).to eq("http://presta/shop/api/")
		end			

		it "returns valid api url when api subresource and no slash" do
			c = PrestaShop::Configuration.new(:api_url => "http://presta/shop/api", :api_key => "PRESTASH00PAPIKEY" )

			expect(c.api_url).to eq("http://presta/shop/api/")
		end				

		it "returns valid api url when slash and api" do
			c = PrestaShop::Configuration.new(:api_url => "http://presta/shop/api/", :api_key => "PRESTASH00PAPIKEY" )

			expect(c.api_url).to eq("http://presta/shop/api/")
		end		

		it "returns valid api url" do
			expect(conf.api_url).to eq("http://presta/shop/api/")
		end

		it "returns valid api key" do
			expect(conf.api_key).to eq("PRESTASH00PAPIKEY")
		end

		it "raises no error on validation" do
			expect{ conf.validate! }.not_to raise_error
		end

		it "should be in release mode" do
			expect(conf.debug?).to be_false
		end

		it "should refer to default shop" do
			expect(conf.default_shop?).to be_true
		end

		it "contains presta_shop user agent header" do
			expect(conf.headers).to include("User-Agent" => "PrestaShop Ruby Library v#{PrestaShop::VERSION}")
		end
	end
end
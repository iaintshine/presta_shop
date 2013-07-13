require "spec_helper"

class MockConfiguration < PrestaShop::Configuration
	def initialize
		super

		self.api_url = "http://presta/shop/api/"
		self.api_key = "PRESTASH00PAPIKEY"
	end
end

describe PrestaShop::URLResolver do
	let(:configuration) { MockConfiguration.new }

	describe "validate!" do
		let(:request_options){ {
			:method => :get,
			:resource => :shops,
			:id => 1
		} }

		it "returns true if valid request options" do
			expect(PrestaShop::URLResolver.new(configuration, request_options).validate! ).to be_true
		end

		it "raises error when unknown resource" do
			invalid_options = { :method => :get, :resource => :invalidresource }
			expect{ PrestaShop::URLResolver.new(configuration, invalid_options).validate! }.to raise_error(PrestaShop::UnknownResource)
		end

		it "raises no error when resource known" do
			PrestaShop::RESOURCES.each do |resource|
				options = { :method => :get, :resource => resource }
				expect{ PrestaShop::URLResolver.new(configuration, options).validate! }.not_to raise_error
			end	
		end
	end

	describe "string convertion" do
		let(:payload) { "<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\"><product><id><![CDATA[ 1 ]]></id></product></prestashop>" }

		let(:escaped_payload) { CGI.escape(payload) }
		
		it "should return valid string when asked for all resources" do
			expect(configuration.api_url).to eq("http://presta/shop/api/")
			expect(PrestaShop::URLResolver.new(configuration, :resource => :shops).to_s).to eq("http://presta/shop/api/shops")
		end

		it "should return valid string when asked for one resource" do
			expect(PrestaShop::URLResolver.new(configuration, :resource => :shops, :id => 1).to_s).to eq("http://presta/shop/api/shops/1")
		end

		it "should return escaped string when payload" do
			options_with_payload = {
				:method => :post,
				:resource => :shops,
				:payload => payload
			}

			expect(PrestaShop::URLResolver.new(configuration, options_with_payload).to_s).to eq("http://presta/shop/api/shops?xml='#{escaped_payload}'")
		end

		it "should return string when query params" do
			options_with_query = { 
				:method => :get,
				:resource => :shops,
				:query => {
					:sort => "name_ASC"
				} 
			}
			expect(PrestaShop::URLResolver.new(configuration, options_with_query).to_s).to eq("http://presta/shop/api/shops?sort=name_ASC")
		end
	end
end
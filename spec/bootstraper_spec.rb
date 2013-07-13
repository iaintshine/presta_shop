require 'spec_helper'

describe "PrestaShop bootstraper" do
	context "basic behaviour" do
		it "raises error when invalid url" do
			PrestaShop.configure do |c|
				c.api_url = "http://invalid/resources/url"
				c.api_key = "PRESTASH00PAPIKEY"
			end

			expect{ PrestaShop.query_permissions }.to raise_error(PrestaShop::InvalidRequest)
		end

		it "raises error when unsupported version" do
			PrestaShop.configure do |c|
				c.api_url = "http://newer/presta/shop"
				c.api_key = "PRESTASH00PAPIKEY"
			end

			expect { PrestaShop.query_permissions }.to raise_error(PrestaShop::UnsupportedVersion)
		end

		it "raises error when invalid credentials" do
			PrestaShop.configure do |c|
				c.api_url = "http://presta/shop"
				c.api_key = "INVALIDAPIKEY"
			end

			expect{ PrestaShop.query_permissions }.to raise_error(PrestaShop::Unauthorized)
		end

		it "raises no error on proper request" do
			PrestaShop.configure do |c|
				c.api_url = "http://presta/shop"
				c.api_key = "PRESTASH00PAPIKEY"
			end

			expect{ PrestaShop.query_permissions }.not_to raise_error
		end
	end

	context "root access" do
		it "has read write access on all resources" do
		end
	end

	context "read only access to products" do
		it "has read only access on products" do
		end
	end
end
require "spec_helper"

describe "PrestaShop::Executor" do
	before(:all) do
		PrestaShop.configure do |c|
			c.api_url = "http://presta/shop"
			c.api_key = "PRESTASH00PAPIKEY"
		end

		# dont like it - make me lazy
		PrestaShop.bootstrap!
	end

	it "raises error when invalid resource" do
		expect{ PrestaShop.execute(:method => :get, :resource => :invalidresource) }.to raise_error(PrestaShop::UnknownResource)
	end

	it "raises error when no permissions" do
		pending "TODO: "
	end

	it "raises error when invalid credentials" do
		pending "TODO: "
	end

	it "raises error when unsupported version" do
		pending "TODO: "
	end

	it "raises no error on proper request" do
		expect{ PrestaShop.execute(:method => :get, :resource => :shops, :id => 1) }.not_to raise_error
	end
end


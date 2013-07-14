require "spec_helper"

describe "PrestaShop" do
	context "valid requests" do
		before(:all) do
			PrestaShop.configure do |c|
				c.api_url = "http://presta/shop"
				c.api_key = "PRESTASH00PAPIKEY"
			end

			# dont like it - make me lazy
			PrestaShop.bootstrap!
		end

		describe "#get" do
			it "raises no error" do
				expect{ PrestaShop.get(:resource => :shops, :id => 1) }.not_to raise_error

			end

			it "returns resource hash" do
				shop = PrestaShop.get(:resource => :shops, :id => 1)

				expect(shop).to include(:id => 1)
				expect(shop).to include(:id_category => 2)
				expect(shop).to include(:id_theme => 2)
				expect(shop).to include(:active => 1)
				expect(shop).to include(:deleted => 0)
				expect(shop).to include(:name => "test")
			end

			it "returns resources array" do
				shops = PrestaShop.get(:resource => :shops)

				expect(shops).to be_instance_of(::Array)
				expect(shops.length).to eq(2)

				expect(shops.first).to include(:id => 1, :href => "http://presta/shop/api/shops/1")
			end
		end

		describe "#head" do
		end

		describe "#create" do
		end

		describe "#update" do
		end

		describe "#delete" do
		end
	end
end
require "spec_helper"

describe "PrestaShop" do
	pending "TOOD: Invalid requests not tested"


	before(:all) do
		PrestaShop.configure do |c|
			c.api_url = "http://presta/shop"
			c.api_key = "PRESTASH00PAPIKEY"
		end

		# dont like it - make me lazy
		PrestaShop.bootstrap!
	end

	context "invalid url" do
	end

	context "invalid credentials - api_key" do
	end

	context "invalid resource name" do
	end

	context "missing attributes" do
	end

	context "basic behaviour" do
		describe "#get" do
			it "raises no error if resource not found" do
				expect{ PrestaShop.get(:resource => :shops, :id => 10) }.not_to raise_error
			end

			it "returns nil if resource not found" do
				expect(PrestaShop.get(:resource => :shops, :id => 10)).to be_false
			end
		end

		describe "#update" do
			let(:invalid_shop) { {
				:id => 10,
				:name => "changed test shop name"
			} }

			it "raises no error if resource not found" do
				expect{ PrestaShop.update(:resource => :shops, :id => invalid_shop[:id], :payload => invalid_shop)}.not_to raise_error
			end

			it "returns false if resource not found" do
				expect(PrestaShop.update(:resource => :shops, :id => invalid_shop[:id], :payload => invalid_shop)).to be_false
			end
		end

		describe "#delete" do
			it "raises no error if resource not found" do
				expect{ PrestaShop.delete(:resource => :shops, :id => 10)}.not_to raise_error
			end

			it "returns false if resource not found" do
				expect(PrestaShop.delete(:resource => :shops, :id => 10)).to be_false
			end
		end
	end

	context "valid requests" do
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
			it "raises no error" do
				expect{ PrestaShop.head(:resource => :shops, :id => 1) }.not_to raise_error
			end

			it "returns true if resource exists" do
				expect( PrestaShop.head(:resource => :shops, :id => 1)).to be_true
			end
		end

		describe "#create" do
			let(:new_shop) { { 
				:id_shop_group => 1,
				:id_category => 2,
				:id_theme => 2,
				:name => "new test shop"
			} }

			it "raises no error" do
				expect{ PrestaShop.create(:resource => :shops, :payload => new_shop) }.not_to raise_error
			end

			it "returns new shop descriptor with valid id" do
				created_shop = PrestaShop.create(:resource => :shops, :payload => new_shop)

				new_shop.each do |key, value|
					expect(created_shop).to include(key => value)
				end

				expect(created_shop).to include(:id => 3)
				expect(created_shop).to include(:active => nil)
				expect(created_shop).to include(:deleted => nil)
				
				# TODO: check error if already exists, and missing required attributes
				# returns 201 at success
				# return 201 and new shop id - you can create shop with the same name multiple times
				# when missing required attribute 400 bad request and error message in xml format
				# when more arguments than required even unknown - creates without error
			end
		end

		describe "#update" do
			# TODO: Check error if not exists, or attributes that not exists
			# TODO: Check if missing id of attribute
			# 404 when do not exists
			let(:shop) { {
				:id => 3,
				:id_shop_group => 1,
				:id_category => 2,
				:id_theme => 2,
				:active => 1,
				:deleted => 0,
				:name => "changed test shop name"
			} }

			it "raises no error" do
				expect{ PrestaShop.update(:resource => :shops, :id => shop[:id], :payload => shop) }.not_to raise_error
			end

			it "return true on successfull update" do
				expect{ PrestaShop.update(:resource => :shops, :id => shop[:id], :payload => shop)}.to be_true
			end
		end

		describe "#delete" do
			# TODO: Check error if already destroyed or on resources not on particular
			# 404 when do not exists

			it "raises no error" do
				expect{ PrestaShop.delete(:resource => :shops, :id => 3) }.not_to raise_error
			end

			it "returns true on success" do
				expect(PrestaShop.delete(:resource => :shops, :id => 3)).to be_true
			end
		end
	end
end
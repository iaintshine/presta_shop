require "spec_helper"


describe "PrestaShop::Model" do
	pending "TODO: Invalid requests not tested"

	before(:all) do
		PrestaShop.configure do |c|
			c.api_url = "http://presta/shop"
			c.api_key = "PRESTASH00PAPIKEY"
			# c.log     = :stderr
			# c.debug   = true
		end

		# dont like it - make me lazy
		PrestaShop.bootstrap!
	end

	context "valid requests" do
		describe "#find" do
			it "raises no error" do
				expect{ PrestaShop::Shop.find(1) }.not_to raise_error
			end

			it "returns resource object" do
				shop = PrestaShop::Shop.find(1)

				expect(shop).to include(:id => 1)
				expect(shop).to include(:id_category => 2)
				expect(shop).to include(:id_theme => 2)
				expect(shop).to include(:active => 1)
				expect(shop).to include(:deleted => 0)
				expect(shop).to include(:name => "test")
			end
		end

		describe "#all" do
			it "raises no error" do
				expect{ PrestaShop::Shop.all }.not_to raise_error
			end

			it "returns resources array" do
				shops = PrestaShop::Shop.all

				expect(shops).to be_instance_of(::Array)
				expect(shops.length).to eq(2)

				expect(shops.first).to include(:id => 1, :href => "http://presta/shop/api/shops/1")
			end
		end

		describe "#exists?" do
			it "raises no error" do
				expect{ PrestaShop::Shop.exists?(1) }.not_to raise_error
			end

			it "returns true if resource exists" do
				expect( PrestaShop::Shop.exists?(1) ).to be_true
			end

			it "returns false if resource does not exists" do
				expect( PrestaShop::Shop.exists?(100) ).to be_false
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
				expect{ PrestaShop::Shop.create(new_shop) }.not_to raise_error
			end

			it "returns new shop descriptor with valid id" do
				created_shop = PrestaShop::Shop.create new_shop

				new_shop.each do |key, value|
					expect(created_shop).to include(key => value)
				end

				expect(created_shop).to include(:id => 3)
				expect(created_shop).to include(:active => nil)
				expect(created_shop).to include(:deleted => nil)
			end
		end

		describe "#update" do
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
				expect{ PrestaShop::Shop.update(shop) }.not_to raise_error
			end

			it "returns true on successfull update" do
				expect{ PrestaShop::Shop.update(shop) }.to be_true
			end
		end

		describe "#save" do
			it "raises no error" do
				expect{ 
					shop = PrestaShop::Shop.find(3) 
					shop.name = "changed test shop name"
					shop.save!
				}.not_to raise_error
			end

			it "returns true on successfull update" do
				shop = PrestaShop::Shop.find(3)
				shop.name = "changed test shop name"
					
				expect(shop.save!).to eq(shop)
			end
		end

		describe "#destroy" do
			it "raises no error" do
				expect{ PrestaShop::Shop.destroy(3) }.not_to raise_error
			end

			it "returns true on success" do
				expect(PrestaShop::Shop.destroy(3)).to be_true
			end

			it "returns false if do not exists" do
				expect(PrestaShop::Shop.destroy(100)).to be_false
			end
		end

		describe "model #delete" do
			pending "TODO:"
		end
	end
end
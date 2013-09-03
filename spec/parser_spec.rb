require "spec_helper"

describe "PrestaShop::Parser" do
    pending "make me better ..."

    context "single resource" do
        before(:all) do
            @response_content = File.read(File.expand_path('../support/static_response/api_shops_1.xml', __FILE__))
        end

        it "contains shop information" do
            shop = PrestaShop::Parser.parse(@response_content, {:id => true})

            expect(shop).to include(:id => 1)
            expect(shop).to include(:id_category => 2)
            expect(shop).to include(:id_theme => 2)
            expect(shop).to include(:active => 1)
            expect(shop).to include(:deleted => 0)
            expect(shop).to include(:name => "test")
        end
    end

    context "single resource without value" do
        before(:all) do
            @response_content = File.read(File.expand_path('../support/static_response/api_shops_create_response.xml', __FILE__))
        end

        it "raises no error" do
            expect{ PrestaShop::Parser.parse(@response_content, {:id => true}) }.not_to raise_error
        end

        it "contains shop information" do
            shop = PrestaShop::Parser.parse(@response_content, {:id => true})

            expect(shop).to include(:id => 3)
            expect(shop).to include(:id_category => 2)
            expect(shop).to include(:id_theme => 2)
            expect(shop).to include(:active => nil)
            expect(shop).to include(:deleted => nil)
            expect(shop).to include(:name => "new test shop")
        end
    end

    context "array of resource ids" do
        before(:all) do
            @response_content = File.read(File.expand_path('../support/static_response/api_shops.xml', __FILE__))
        end

        it "contains shop ids" do
            shops = PrestaShop::Parser.parse(@response_content, {:id => nil, :display => nil})

            expect(shops).to be_instance_of(::Array)
            expect(shops.length).to eq(2)

            expect(shops.first).to include(:id => 1)
            expect(shops.first).to include(:href => "http://presta/shop/api/shops/1")

            expect(shops.last).to include(:id => 2)
            expect(shops.last).to include(:href => "http://presta/shop/api/shops/2")

        end
    end

    context "array of resources" do
        before(:all) do
            # TODO:
            @response_content = File.read(File.expand_path('../support/static_response/api_shops.xml', __FILE__))
        end

        it "does not contain any tests" do
        end
    end
end
require "spec_helper"

describe PrestaShop::QueryParams do 
    describe "validate!" do
        let(:all_params) { {
            :xml => "<prestashop></prestashop>",
            :filter => "",
            :display => "",
            :sort => "",
            :limit => "",
            :schema => "",
            :date => "",
            :id_shop => ""
        } }

        it "throws exception when unknown params" do
            expect{ PrestaShop::QueryParams.new({"unknown" => "option"}).validate! }.to raise_error(PrestaShop::UnsupportedParamsError)
        end

        it "returns true if nil" do
            expect( PrestaShop::QueryParams.new(nil).validate! ).to be_true
        end

        it "returns true if empty options" do
            expect( PrestaShop::QueryParams.new({}).validate! ).to be_true
        end

        it "returns true when param are known" do
            expect( PrestaShop::QueryParams.new({:sort => "email_ASC"}).validate! ).to be_true
        end

        it "returns true when all known params" do
            expect( PrestaShop::QueryParams.new(all_params).validate! ).to be_true
        end
    end

    describe "string convertion" do
        it "returns empty string if nil" do
            expect(PrestaShop::QueryParams.new(nil).to_s).to eq("")
        end

        it "returns empty string if empty options" do
            expect(PrestaShop::QueryParams.new({}).to_s).to eq("")
        end

        it "returns query params string" do
            expect(PrestaShop::QueryParams.new({:sort => "email_ASC"}).to_s).to eq("sort=email_ASC")
        end
    end
end
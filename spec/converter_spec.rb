require 'spec_helper'

describe "PrestaShop::Converter" do
	it "creates presta xml from hash" do
		shop = {
			:id => 1, 
			:id_category => 2,
			:id_theme => 2,
			:active => 1,
			:deleted => 0,
			:name => "test"
		}

		shop_pattern = File.read(File.expand_path('../support/static_response/api_shops_1.xml', __FILE__))

		expect( PrestaShop::Converter.convert(:shops, shop) ).to eq(shop_pattern)
	end
end
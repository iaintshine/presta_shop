require 'spec_helper'

describe "PrestaShop::Converter" do
	let(:shop) { {
			:id => 1, 
			:id_shop_group => 1,
			:id_category => 2,
			:id_theme => 2,
			:active => 1,
			:deleted => 0,
			:name => "test"
	} }

	it "raises error when unknown resource to convert" do
		expect{ PrestaShop::Converter.convert(:invalidresource, shop) }.to raise_error(PrestaShop::UnknownResource)
	end

	it "raises no error when resource known" do
		expect{ PrestaShop::Converter.convert(:shops, shop) }.not_to raise_error
	end

	it "creates presta xml from hash" do
		shop_xml = PrestaShop::Converter.convert(:shops, shop)
		
		expect( shop_xml ).to include("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
		expect( shop_xml ).to include("<prestashop xmlns:xlink=\"http://www.w3.org/1999/xlink\">")
		expect( shop_xml ).to include("<shop>")
		expect( shop_xml ).to include("<id><![CDATA[1]]></id>")
		expect( shop_xml ).to include("<id_shop_group><![CDATA[1]]></id_shop_group>")
		expect( shop_xml ).to include("<id_category><![CDATA[2]]></id_category>")
		expect( shop_xml ).to include("<id_theme><![CDATA[2]]></id_theme>")
		expect( shop_xml ).to include("<active><![CDATA[1]]></active>")
		expect( shop_xml ).to include("<deleted><![CDATA[0]]></deleted>")
		expect( shop_xml ).to include("<name><![CDATA[test]]></name>")
		expect( shop_xml ).to include("</shop>")
		expect( shop_xml ).to include("</prestashop>")
	end
end
require "spec_helper"

describe PrestaShop::RestPermissions do
    context "basic behaviour" do
        let(:permissions) { PrestaShop::RestPermissions.new }

        it "should response to resource" do
            expect(permissions.respond_to?("addresses")).to be_true
        end

        it "should have resource using array operator" do
            expect(permissions["addresses"]).not_to be_false
        end

        it "should have resource using missing" do
            expect(permissions.addresses).not_to be_false
        end

        it "raise error when unknown resource" do
            expect{ permissions["invalid resource"] = nil }.to raise_error(ArgumentError)
        end

        it "raise error when invalid methods class" do
            expect{ permissions["addresses"] = Hash.new }.to raise_error(ArgumentError)
        end
    end

    context "checking on when no permissions" do
        it "should not allow any call" do
            p = PrestaShop::RestPermissions.new

            PrestaShop::RESOURCES.each do |resource|
                expect(p[resource].any?).to be_false
                
                supported_methods = p.send resource
                expect(supported_methods.any?).to be_false
            end
        end
    end

    context "checking on when read permissions" do
        it "should be valid ? " do
            addresses_permissions = PrestaShop::RestMethods.new :head => true, :get => true

            p = PrestaShop::RestPermissions.new
            p["addresses"] = addresses_permissions

            expect(p.addresses.any?).to be_true
            expect(p.addresses.read_only?).to be_true
            expect(p.addresses.write_only?).to be_false
            expect(p.addresses.read_write?).to be_false 
        end
    end

    context "checking on when root (all) permissions" do
        it "should be valid" do
            rw_permissions = PrestaShop::RestMethods.new :head => true, :get => true, :post => true, :put => true, :delete => true

            p  = PrestaShop::RestPermissions.new

            PrestaShop::RESOURCES.each do |resource|
                p[resource] = rw_permissions
            end

            PrestaShop::RESOURCES.each do |resource|
                expect(p.addresses.any?).to be_true
                expect(p.addresses.read_only?).to be_false
                expect(p.addresses.write_only?).to be_false
                expect(p.addresses.read_write?).to be_true 
            end
        end
    end
end
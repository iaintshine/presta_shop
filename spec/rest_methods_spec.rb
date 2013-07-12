require "spec_helper"

describe PrestaShop::RestMethods do
	it "should not support any method when default" do
		m = PrestaShop::RestMethods.new

		expect(m.supported?(:head)).to be_false
		expect(m.supported?(:get)).to be_false
		expect(m.supported?(:post)).to be_false
		expect(m.supported?(:put)).to be_false
		expect(m.supported?(:delete)).to be_false
		expect(m.any?).to be_false
	end

	it "should not support any method when nil" do
		m = PrestaShop::RestMethods.new nil

		expect(m.supported?(:head)).to be_false
		expect(m.supported?(:get)).to be_false
		expect(m.supported?(:post)).to be_false
		expect(m.supported?(:put)).to be_false
		expect(m.supported?(:delete)).to be_false
		expect(m.any?).to be_false
	end

	it "should not support any method when empty" do
		m = PrestaShop::RestMethods.new({})

		expect(m.supported?(:head)).to be_false
		expect(m.supported?(:get)).to be_false
		expect(m.supported?(:post)).to be_false
		expect(m.supported?(:put)).to be_false
		expect(m.supported?(:delete)).to be_false
		expect(m.any?).to be_false
	end

	it "should return valid values" do
		m = PrestaShop::RestMethods.new :head => true, :get => true

		expect(m.supported?(:head)).to be_true
		expect(m.supported?(:get)).to be_true
		expect(m.supported?(:post)).to be_false
		expect(m.supported?(:put)).to be_false
		expect(m.supported?(:delete)).to be_false
	end

	it "should be read only" do
		m = PrestaShop::RestMethods.new :head => true

		expect(m.read_only?).to be_true
		expect(m.write_only?).to be_false
		expect(m.read_write?).to be_false
		expect(m.any?).to be_true
	end

	it "should be write only" do
		m = PrestaShop::RestMethods.new :post => true

		expect(m.read_only?).to be_false
		expect(m.write_only?).to be_true
		expect(m.read_write?).to be_false
		expect(m.any?).to be_true
	end

	it "should be read write" do
		m = PrestaShop::RestMethods.new :head => true, :post => true

		expect(m.read_only?).to be_false
		expect(m.write_only?).to be_false
		expect(m.read_write?).to be_true
		expect(m.any?).to be_true
	end
end
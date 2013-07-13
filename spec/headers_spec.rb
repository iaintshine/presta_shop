require 'spec_helper'

class MockResponse

	include RestClient::AbstractResponse

	def initialize(version = nil)
		@headers = Hash.new
		@headers[:psws_version] = version if version
	end
end

describe "PrestaShop::Headers" do
	let(:higher_version) { "1.0.0" }
	let(:lower_version)  { "2.0.0" }
	let(:supported_version) { "1.5.0" }

	context "checking supported version" do
		it "returns false if version lower than supported" do
			expect(PrestaShop::Headers.new(MockResponse.new(lower_version)).valid_version?).to be_false
		end

		it "returns false if version higher than supported" do
			expect(PrestaShop::Headers.new(MockResponse.new(higher_version)).valid_version?).to be_false
		end

		it "return true if version supported" do
			expect(PrestaShop::Headers.new(MockResponse.new(supported_version)).valid_version?).to be_true
		end
	end

	context "validating response headers" do
		it "throws exception if header missing" do
			expect{ PrestaShop::Headers.new(MockResponse.new).validate! }.to raise_error(ArgumentError)
		end

		it "throws exception if version lower than supported" do
			expect{ PrestaShop::Headers.new(MockResponse.new(lower_version)).validate! }.to raise_error(PrestaShop::UnsupportedVersion)
		end

		it "throws exception if version higher than supported" do
			expect{ PrestaShop::Headers.new(MockResponse.new(higher_version)).validate! }.to raise_error(PrestaShop::UnsupportedVersion)
		end

		it "does not throw any exception if version supported" do
			expect{ PrestaShop::Headers.new(MockResponse.new(supported_version)).validate!}.not_to raise_error
		end
	end
end
require 'spec_helper'

describe "Hash extension" do
	context :except do
		let(:h) { {:foo => "foo", :bar => "bar"} }
		let(:property) { :foo }

		it "returns a new object" do
			expect(h.except(property)).not_to equal(h)
		end

		it "should not have a property" do
			expect(h.except(property)).not_to include(property)
		end
	end

	context :except! do
		let(:h) { {:foo => "foo", :bar => "bar"} }
		let(:property) { :foo }

		it "should not have a property" do
			expect(h.except!(property)).not_to include(property)
		end
	end
end
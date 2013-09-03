require 'spec_helper'

describe "String extension" do
    context "checking url validity" do
        it "returns false if not uri" do
            expect("invalid uri".valid_url?).to be_false
        end

        it "returns false if not http or https" do
            expect("file:///localhost/some/file".valid_url?).to be_false
        end

        it "returns true if valid http url" do
            expect("http://some/resource".valid_url?).to be_true
        end

        it "returns true if valid https url" do
            expect("https://some/resource".valid_url?).to be_true
        end
    end

    context "checking whether is boolean or not" do
        it "throws exception if neither true nor false" do
            str = "lorem ipsum"
            expect{ str.to_boolean }.to raise_error(ArgumentError)
        end

        it "returns false if empty" do
            expect("".to_boolean).to be_false
        end

        it "returns false if false|f|no|n|0" do
            %w{false f no n 0}.each do |s|
                expect(s.to_boolean).to be_false
            end
        end

        it "returns true if true|t|yes|y|1" do
            %w{true t yes y 1}.each do |s|
                expect(s.to_boolean).to be_true
            end
        end
    end
end
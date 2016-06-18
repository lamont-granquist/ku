
require "spec_helper"
require "ku/mod"
require "json"

describe Ku::Mod do
  let(:data_file) { File.join(SPEC_DATA, "KerboKatzUtilities-1.3.7.ckan") }
  let(:json) { IO.read(data_file) }
  let(:hash) { JSON.parse(json) }

  context "#eql?" do
    let(:a) { Ku::Mod.from_json(json) }
    let(:b) { Ku::Mod.from_json(json) }

    it "identical mods should be identical" do
      expect(a).to eql(b)
    end

    it "changed mods should not be identical" do
      a.name = "something else"
      expect(a).not_to eql(b)
    end
  end

  context "round trips" do
    it "should round trip from json to json" do
      expect( Ku::Mod.from_json(json).to_json ).to eql(JSON.generate(JSON.parse(json)))
    end

    it "should round trip from hash to a hash" do
      expect( Ku::Mod.from_hash(hash).to_hash ).to eql(hash)
    end

    it "should produce the same result from_json as it does from_hash" do
      expect( Ku::Mod.from_json(json) ).to eql(Ku::Mod.from_hash(hash))
    end

    it "should produce the same result from_file as it does from_hash" do
      expect( Ku::Mod.from_file(data_file) ).to eql(Ku::Mod.from_hash(hash))
    end
  end
end

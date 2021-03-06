require 'spec_helper'

describe Automatic::Client::Vehicles do
  let(:vehicle_file) do
    File.read(File.expand_path('../../data/vehicle.json', __FILE__))
  end

  let(:vehicle) do
    MultiJson.load(vehicle_file)
  end

  let(:collection) { [vehicle] }

  subject { described_class.new(collection) }

  context "with no records" do
    let(:collection) { [] }

    it "returns 0 for the #count" do
      expect(subject.count).to eq(0)
    end

    it "returns false for #any?" do
      expect(subject.any?).to be_false
    end
  end

  context "with a single record" do
    it "returns 1 for the #count" do
      expect(subject.count).to eq(1)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end

  context "with 10 records" do
    let(:collection) { (1..10).map { vehicle } }

    it "returns 10 for the #count" do
      expect(subject.count).to eq(10)
    end

    it "returns true for #any?" do
      expect(subject.any?).to be_true
    end
  end
end

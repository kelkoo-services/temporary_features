require "spec_helper"

describe TemporaryFeatures::RoutingHelpers do
  subject do
    class DummyClass
      include TemporaryFeatures::RoutingHelpers
    end
    DummyClass.new
  end

  describe "#temporary_feature" do
    before do
      subject.stub(:constraints) do |tfc, &block|
        if tfc.matches?(double("Request"))
          block.call
        end
      end
    end

    it "should create a constraints that calls the block" do
      tfc = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: true)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy).and_return(tfc)
      res = subject.temporary_feature(:dummy) do
        "matches"
      end
      expect(res).to eq "matches"
    end

    it "should create a constraints that doesn't call the block" do
      tfc = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: false)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy).and_return(tfc)
      res = subject.temporary_feature(:dummy) do
        "matches"
      end
      expect(res).to be_nil
    end

    it "should create two constraints and call the block with true" do
      tfc1 = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: true)
      tfc2 = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: false)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy).and_return(tfc1)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy, true).and_return(tfc2)
      res = []
      subject.temporary_feature(:dummy) do |enabled|
        res << enabled
      end
      expect(res).to eq [true]
    end

    it "should create two constraints and call the block with false" do
      tfc1 = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: false)
      tfc2 = double("TemporaryFeatures::TemporaryFeatureConstraint", matches?: true)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy).and_return(tfc1)
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy, true).and_return(tfc2)
      res = []
      subject.temporary_feature(:dummy) do |enabled|
        res << enabled
      end
      expect(res).to eq [false]
    end
  end
end

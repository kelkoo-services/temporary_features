require "spec_helper"

describe TemporaryFeatures::RoutingHelpers do
  subject do
    class DummyClass
      include TemporaryFeatures::RoutingHelpers
    end
    DummyClass.new
  end

  describe "#temporary_feature" do
    it "should create a constraints" do
      tfc = double("TemporaryFeatures::TemporaryFeatureConstraint")
      TemporaryFeatures::TemporaryFeatureConstraint.should_receive(:new).with(:dummy).and_return(tfc)
      subject.should_receive(:constraints).with(tfc) # how do we know the block was passed?
      subject.temporary_feature(:dummy) do
        # stuff
      end
    end
  end
end

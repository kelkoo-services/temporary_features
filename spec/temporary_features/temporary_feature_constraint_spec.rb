require "spec_helper"

describe TemporaryFeatures::TemporaryFeatureConstraint do
  subject do
    TemporaryFeatures::TemporaryFeatureConstraint.new(:dummy)
  end

  describe "#temporary_feature" do
    describe "when feature is enabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: true)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should match" do
        subject.matches?(double).should be_true
      end
    end

    describe "when feature is disabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: false)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should not match" do
        subject.matches?(double).should be_false
      end
    end
  end
end

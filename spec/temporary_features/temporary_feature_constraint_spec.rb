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
        request = double("http request", params: {}, session: {})
        subject.matches?(request).should be_true
      end
    end

    describe "when feature is enabled but negated" do
      subject do
        TemporaryFeatures::TemporaryFeatureConstraint.new(:dummy, true)
      end

      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: true)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should not match" do
        request = double("http request", params: {}, session: {})
        subject.matches?(request).should be_false
      end
    end

    describe "when feature is disabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: false)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should not match" do
        request = double("http request", params: {}, session: {})
        subject.matches?(request).should be_false
      end
    end

    describe "when feature is disabled but negated" do
      subject do
        TemporaryFeatures::TemporaryFeatureConstraint.new(:dummy, true)
      end

      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: false)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should match" do
        request = double("http request", params: {}, session: {})
        subject.matches?(request).should be_true
      end
    end

    describe "when adding a parameter to skip the theck" do
      before do
        TemporaryFeatures::TemporaryFeature.should_not_receive(:new)
      end

      it "should match even if the feature is disabled" do
        request = double("http request", params: { stfcf: "dummy" }, session: {})
        subject.matches?(request).should be_true
      end
    end

    describe "when stored in session a parameter to skip the theck" do
      before do
        TemporaryFeatures::TemporaryFeature.should_not_receive(:new)
      end

      it "should match even if the feature is disabled" do
        request = double("http request", params: {}, session: { stfcf: "dummy" })
        subject.matches?(request).should be_true
      end
    end
  end
end

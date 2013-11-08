require "spec_helper"

describe TemporaryFeatures::ControllerHelpers do
  subject do
    class DummyClass
      include TemporaryFeatures::ControllerHelpers
    end
    DummyClass.new
  end

  describe "#temporary_feature" do
    describe "when feature is enabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: true)
        TemporaryFeatures::TemporaryFeature.stub(:new).and_return(tf)
      end

      it "should call block" do
        expect do |b|
          subject.temporary_feature(:dummy, &b)
        end.to yield_control
      end
    end

    describe "when feature is disabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: false)
        TemporaryFeatures::TemporaryFeature.stub(:new).and_return(tf)
      end

      it "should not call block" do
        expect do |b|
          subject.temporary_feature(:dummy, &b)
        end.not_to yield_control
      end
    end
  end
end

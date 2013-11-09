require "spec_helper"

describe TemporaryFeatures::ControllerHelpers do
  subject do
    class DummyClass
      include TemporaryFeatures::ControllerHelpers
    end
    DummyClass.new
  end

  before do
    subject.stub(:params).and_return({})
    subject.stub(:session).and_return({})
  end

  describe "#temporary_feature" do
    describe "when feature is enabled" do
      before do
        tf = double("TemporaryFeatures::TemporaryFeature", enabled?: true)
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
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
        TemporaryFeatures::TemporaryFeature.should_receive(:new).with(:dummy).and_return(tf)
      end

      it "should not call block" do
        expect do |b|
          subject.temporary_feature(:dummy, &b)
        end.not_to yield_control
      end
    end

    describe "when adding a parameter to skip the check" do
      before do
        TemporaryFeatures::TemporaryFeature.should_not_receive(:new)
        subject.stub(:params).and_return({ stfcf: "dummy" })
      end

      it "should call block even if the feature is disabled" do
        expect do |b|
          subject.temporary_feature(:dummy, &b)
        end.to yield_control
      end
    end

    describe "when stored in session a parameter to skip the check" do
      before do
        TemporaryFeatures::TemporaryFeature.should_not_receive(:new)
        subject.stub(:session).and_return({ stfcf: "dummy" })
      end

      it "should call block even if the feature is disabled" do
        expect do |b|
          subject.temporary_feature(:dummy, &b)
        end.to yield_control
      end
    end
  end

  describe "#remember_skip_temporary_feature_check_for" do
    it "should store the skip parameter in session" do
      session = {}
      subject.stub(:session).and_return(session)
      subject.stub(:params).and_return({ stfcf: "dummy" })
      subject.remember_skip_temporary_feature_check_for
      session[:stfcf].should == "dummy"
    end
  end
end

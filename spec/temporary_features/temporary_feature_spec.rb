require "spec_helper"

describe TemporaryFeatures::TemporaryFeature do
  subject { TemporaryFeatures::TemporaryFeature.new(:dummy_feature) }

  before do
    TemporaryFeatures.configure do |config|
      config.settings = {
        "dummy_feature" => {
          "from" => Time.parse("2013-11-08 16:00:00 +0100"),
          "to"   => Time.parse("2013-11-15 23:59:59 +0100")
        },
        "never_ending_feature" => {
          "from" => Time.parse("2013-11-08 16:00:00 +0100")
        }
      }
    end
  end

  describe "before start date" do
    before { Delorean.time_travel_to Time.parse("2013-11-08 15:59:50 +0100") }
    after  { Delorean.back_to_1985 }

    it { should_not be_enabled }
  end

  describe "between start date and end date" do
    before { Delorean.time_travel_to Time.parse("2013-11-10 11:12:13 +0100") }
    after  { Delorean.back_to_1985 }

    it { should be_enabled }
  end

  describe "after end date" do
    before { Delorean.time_travel_to Time.parse("2013-11-16 00:00:00 +0100") }
    after  { Delorean.back_to_1985 }

    it { should_not be_enabled }
  end

  describe "unknown features" do
    subject { TemporaryFeatures::TemporaryFeature.new(:unknown_feature) }

    it { should_not be_enabled }
  end

  describe "feature without to before start date" do
    before { Delorean.time_travel_to Time.parse("2013-11-07 00:00:00 +0100") }
    after  { Delorean.back_to_1985 }
    subject { TemporaryFeatures::TemporaryFeature.new(:never_ending_feature) }

    it {should_not be_enabled}
  end

  describe "feature without to after start date" do
    before { Delorean.time_travel_to Time.parse("2013-11-10 00:00:00 +0100") }
    after  { Delorean.back_to_1985 }
    subject { TemporaryFeatures::TemporaryFeature.new(:never_ending_feature) }

    it {should be_enabled}
  end

end

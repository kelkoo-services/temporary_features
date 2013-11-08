module TemporaryFeatures
  class TemporaryFeature
    def initialize(id)
      settings = settings_for(id)
      @start_time = settings["from"]
      @end_time   = settings["to"]
    end

    def enabled?
      now = Time.now
      (@start_time <= now) and (now <= @end_time)
    end

    private

    def settings_for(id)
      TemporaryFeatures.configuration.settings[id.to_s]
    end
  end
end

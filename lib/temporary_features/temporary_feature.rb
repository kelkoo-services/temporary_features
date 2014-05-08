module TemporaryFeatures
  class TemporaryFeature
    def initialize(id)
      @id = id
    end

    def enabled?
      return unless settings?

      now = Time.now
      (start_time <= now) and ( end_time.nil? || (now <= end_time))
    end

    private

    def start_time
      settings["from"]
    end

    def end_time
      settings["to"]
    end

    def settings
      @settings ||= settings_for(@id)
    end

    def settings?
      !! settings
    end

    def settings_for(id)
      TemporaryFeatures.configuration.settings[id.to_s]
    end
  end
end

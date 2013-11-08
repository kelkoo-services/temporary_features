module TemporaryFeatures
  class TemporaryFeatureConstraint
    def initialize(feature_id)
      @feature_id = feature_id
    end

    def matches?(request)
      TemporaryFeature.new(@feature_id).enabled?
    end
  end
end

require "temporary_features/temporary_feature_constraint"

module TemporaryFeatures
  module RoutingHelpers
    def temporary_feature(feature_id, &block)
      constraints TemporaryFeatureConstraint.new(feature_id), &block
    end
  end
end

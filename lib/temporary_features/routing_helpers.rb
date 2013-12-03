require "temporary_features/temporary_feature_constraint"

module TemporaryFeatures
  module RoutingHelpers
    def temporary_feature(feature_id, &block)
      if block.arity == 0
        constraints TemporaryFeatureConstraint.new(feature_id), &block
      else
        constraints TemporaryFeatureConstraint.new(feature_id) do
          block.call(true)
        end
        constraints TemporaryFeatureConstraint.new(feature_id, true) do
          block.call(false)
        end
      end
    end
  end
end

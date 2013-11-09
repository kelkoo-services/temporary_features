module TemporaryFeatures
  class Railtie < Rails::Railtie
    initializer "temporary_features.controller_helpers" do
      ActionController::Base.send :include, ControllerHelpers
      ActionController::Base.send :before_filter, :remember_skip_temporary_feature_check_for
      ActionController::Base.helper_method :temporary_feature
    end

    initializer "temporary_features.routing_helpers" do
      ActionDispatch::Routing::Mapper.send :include, RoutingHelpers
    end
  end
end

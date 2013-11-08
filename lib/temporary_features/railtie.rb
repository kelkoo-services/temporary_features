module TemporaryFeatures
  class Railtie < Rails::Railtie
    initializer "temporary_features.helpers" do
      ActionController::Base.send :include, Helpers
      ActionController::Base.helper_method :temporary_feature
    end
  end
end

module TemporaryFeatures
  module ControllerHelpers
    def temporary_feature(feature_id, &block)
      block.call if skip_temporary_feature_check_for?(feature_id) || TemporaryFeature.new(feature_id).enabled?
    end

    def skip_temporary_feature_check_for?(feature_id)
      skip_temporary_feature_check_for == feature_id.to_s
    end

    def skip_temporary_feature_check_for
      params[:stfcf] || session[:stfcf]
    end

    def remember_skip_temporary_feature_check_for
      session[:stfcf] = skip_temporary_feature_check_for
    end
  end
end

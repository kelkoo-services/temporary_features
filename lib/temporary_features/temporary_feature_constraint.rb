module TemporaryFeatures
  class TemporaryFeatureConstraint
    def initialize(feature_id)
      @feature_id = feature_id
    end

    def matches?(request)
      skip_check?(request) || TemporaryFeature.new(@feature_id).enabled?
    end

    private

    def skip_check?(request)
      skip_check_for = request.params[:stfcf] || request.session[:stfcf]
      skip_check_for == @feature_id.to_s
    end
  end
end

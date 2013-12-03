module TemporaryFeatures
  class TemporaryFeatureConstraint
    def initialize(feature_id, negate = false)
      @feature_id, @negate = feature_id, negate
    end

    def matches?(request)
      matches = skip_check?(request) || TemporaryFeature.new(@feature_id).enabled?
      matches = !matches if @negate
      matches
    end

    private

    def skip_check?(request)
      skip_check_for = request.params[:stfcf] || request.session[:stfcf]
      skip_check_for == @feature_id.to_s
    end
  end
end

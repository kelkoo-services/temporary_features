require "temporary_features/version"
require "temporary_features/configuration"
require "temporary_features/temporary_feature"
require "temporary_features/helpers"
require "/home/francis/workspace/temporary_features/lib/temporary_features/railtie.rb" if defined?(Rails)

module TemporaryFeatures
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end

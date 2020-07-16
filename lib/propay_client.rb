require 'propay_client/configuration'
require 'propay_client/api'
require "propay_client/resources"
require 'propay_client/version'

module PropayClient
  class << self
    attr_accessor :configuration, :initialized
  end

  def self.configuration
    raise "You need to configure PropayClient first!" unless @initialized
    @configuration ||= Configuration.new
  end

  def self.configure
    @initialized = true
    yield(configuration)
  end
end

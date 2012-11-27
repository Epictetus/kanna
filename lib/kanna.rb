require "kanna/version"
require "active_support/configurable"

module Kanna
  include ActiveSupport::Configurable

  configure do |config|
    config.phonegap_path = File.join('~', 'install', 'phonegap-2.0.0')
  end

  require "kanna/railtie"
end

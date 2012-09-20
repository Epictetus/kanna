require "pera/version"
require "active_support/configurable"

module Pera
  include ActiveSupport::Configurable

  configure do |config|
    config.phonegap_path = File.join('~', 'install', 'phonegap-2.0.0')
  end
end

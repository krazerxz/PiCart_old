require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

Dir[File.join(File.dirname(__FILE__), '..', 'app', 'services', '*.rb')].each    { |f| require f }

module PiCart
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
  end
end

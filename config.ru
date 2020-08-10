# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
EmailVerifier.config do |config|
  config.test_mode = Rails.env.test?
end
run Rails.application

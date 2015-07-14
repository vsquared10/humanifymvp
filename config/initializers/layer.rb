Layer::Client.configure do |config|
  config.app_id = ENV['LAYER_APP_ID']
  config.token = ENV['LAYER_PLATFORM_TOKEN']
end

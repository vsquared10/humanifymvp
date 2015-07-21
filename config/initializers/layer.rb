Layer::Client.configure do |config|
  config.app_id = ENV['LAYER_KEY_ID']
  config.token = ENV['LAYER_PLATFORM_TOKEN']
end

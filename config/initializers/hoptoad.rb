HoptoadNotifier.configure do |config|
  config.api_key = APP_CONFIG['hoptoad_token']
  config.js_notifier = true
end
Slack.configure do |config|
  config.token = ENV.fetch('SLACK_RUPERT_API_TOKEN', nil)
end

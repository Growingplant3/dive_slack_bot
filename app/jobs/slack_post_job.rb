class SlackPostJob < ApplicationJob
  queue_as :default

  def perform(bot_requirement)
    client = SlackPostJob.client
    client.notify(bot_requirement)
  end

  def self.client
    SlackNotify::Client.new(
      webhook_url: ENV['SLACK_WEBHOOK_URL'],
      channel: "#gemの実装",
      username: "mybot",
      link_names: 1
    )
  end
end

class SlackPostJob < ApplicationJob
  include Clockwork
  queue_as :default

  def perform(bot_requirement)
    client = SlackPostJob.client
    # client.notify(bot_requirement)
    every(5.seconds, 'SlackPostJob') { Delayed::Job.enqueue(client.notify(Bot.find(rand(1..Bot.all.count)).requirement)) }
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

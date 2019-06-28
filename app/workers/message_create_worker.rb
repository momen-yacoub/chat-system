class MessageCreateWorker
  include Sidekiq::Worker

  def perform(args)
    Message.create!(chat_id: args['chat_id'], message_number: args['message_number'])
  end
end

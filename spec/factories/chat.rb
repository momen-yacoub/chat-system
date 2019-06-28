FactoryBot.define do
  factory :chat do
    sequence(:chat_number) {|n| "chat_number_#{n}"}
    messages_count {0}
    messages
  end
end
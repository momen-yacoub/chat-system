FactoryBot.define do
  factory :chat do
    sequence(:chat_number) {|n| "chat_number_#{n}"}
    messages_count {0}
    messages

    factory :chat_with_messages do
      transient do
        messages []
      end

      after(:create) do |chat, evaluator|
        chat.messages << evaluator.messages
      end
    end
  end
end
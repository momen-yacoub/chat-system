FactoryBot.define do
  factory :message do
    sequence(:message_number) {|n| "message_number_#{n}"}
    messages_count {0}
  end
end
FactoryBot.define do
  factory :application do
    desc {Faker::Lorem.paragraph}
    sequence(:token) {|n| "token_#{n}"}
    chats_count {0}
    chats
  end
end
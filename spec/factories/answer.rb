FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "本文#{n}" }
    association :user
    association :question
  end
end

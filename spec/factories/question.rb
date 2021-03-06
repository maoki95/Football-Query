# == Schema Information
#
# Table name: boards
#
#  id          :bigint           not null, primary key
#  title       :string(100)      not null
#  body        :text(10000)      not null
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_image :string(255)
#

FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:body) { |n| "本文#{n}" }
    association :user

    trait :unsolve do
      status { unsoleve }
    end

    trait :solve do
      status { soleve }
    end
  end
end

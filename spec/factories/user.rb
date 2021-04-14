FactoryBot.define do
factory :user do
  email { 'example@sample.com' }
  password { '12345678' }
  password_confirmation { '12345678' }
  name { "たろう" }
  introduce {'こんにちは'}
end
end
FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    password '123456'
    provider { 'email' }
  end
end
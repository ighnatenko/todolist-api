# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { FFaker::Book.title }
    index { rand(100) }
    done { false }
    expiration_date { FFaker::Time.between(Time.now, 3.months.ago) }
    project
  end
end

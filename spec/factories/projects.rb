# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { FFaker::Book.title }
    user
  end
end

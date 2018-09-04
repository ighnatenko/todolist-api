# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { FFaker::Book.title }
    task
  end
end

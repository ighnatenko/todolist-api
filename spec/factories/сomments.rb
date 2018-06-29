FactoryBot.define do
  factory :comment do
    content { FFaker::Book.title }
    task
  end
end

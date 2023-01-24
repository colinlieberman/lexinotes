# frozen_string_literal: true

FactoryBot.define do
  factory :citation do
    sequence(:book) { |n| "book-#{n}" }
    sequence(:chapter)
    sequence(:verse)
    sequence(:comments) { |n| "some comments #{n}" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    sequence(:content) { |n| "some content-#{n}" }
    study_date { DateTime.now }
  end
end

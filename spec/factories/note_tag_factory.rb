# frozen_string_literal: true

FactoryBot.define do
  factory :note_tag do
    note { create(:note) }
    tag { create(:tag) }
  end
end

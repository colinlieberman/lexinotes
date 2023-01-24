# frozen_string_literal: true

FactoryBot.define do
  factory :note_citation do
    note { create(:note) }
    citation { create(:citation) }
  end
end

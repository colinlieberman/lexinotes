# frozen_string_literal: true

require "rails_helper"

RSpec.describe Note, type: :model do
  describe "validations" do
    subject { build(:note) }
    it { is_expected.to validate_presence_of(:study_date) }
    it { is_expected.to validate_presence_of(:active) }
    it { is_expected.to validate_numericality_of(:notebook_number).only_integer }
    it { is_expected.to validate_numericality_of(:notebook_page).only_integer }
  end

  describe "to_json" do
    it "includes stringified citations and tags, and formatted date" do
      note = create(:note)
      create(:citation).notes.push(note)
      create(:tag).notes.push(note)

      note.reload

      json = JSON.parse(note.to_json)

      expect(json["study_date"]).to eq(note.study_date_str)
      expect(json["citations"]).to eq(note.citations_str)
      expect(json["tags"]).to eq(note.tags_str)
    end
  end
end

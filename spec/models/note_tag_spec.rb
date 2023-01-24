# frozen_string_literal: true

require "rails_helper"

RSpec.describe NoteTag, type: :model do
  describe "validations" do
    subject { create(:note_tag) }
    it { is_expected.to validate_presence_of(:note_id) }
    it { is_expected.to validate_uniqueness_of(:note_id).scoped_to(:tag_id) }

    it { is_expected.to validate_presence_of(:tag_id) }
    it { is_expected.to validate_uniqueness_of(:tag_id).scoped_to(:note_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:note) }
    it { is_expected.to belong_to(:tag) }
  end
end

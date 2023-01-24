# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "validations" do
    subject { build(:tag) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:note_tags) }
    it { is_expected.to have_many(:notes).through(:note_tags) }
  end
end

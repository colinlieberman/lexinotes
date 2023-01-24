# frozen_string_literal: true

require "rails_helper"

RSpec.describe Citation, type: :model do
  describe "validations" do
    subject { build(:citation) }
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_uniqueness_of(:book).case_insensitive.scoped_to(%i[chapter verse]) }

    it { is_expected.to validate_presence_of(:chapter) }
    it { is_expected.to validate_uniqueness_of(:chapter).scoped_to(%i[book verse]) }
    it { is_expected.to validate_numericality_of(:chapter).only_integer }

    it { is_expected.to validate_presence_of(:verse) }
    it { is_expected.to validate_uniqueness_of(:verse).scoped_to(%i[book chapter]) }
    it { is_expected.to validate_numericality_of(:verse).only_integer }
  end

  describe "associations" do
    it { is_expected.to have_many(:note_citations) }
    it { is_expected.to have_many(:notes).through(:note_citations) }
  end
end

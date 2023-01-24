# frozen_string_literal: true

require "rails_helper"

RSpec.describe NoteCitation, type: :model do
  describe "validations" do
    subject { create(:note_citation) }
    it { is_expected.to validate_presence_of(:note_id) }
    it { is_expected.to validate_uniqueness_of(:note_id).scoped_to(:citation_id) }

    it { is_expected.to validate_presence_of(:citation_id) }
    it { is_expected.to validate_uniqueness_of(:citation_id).scoped_to(:note_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:note) }
    it { is_expected.to belong_to(:citation) }
  end
end

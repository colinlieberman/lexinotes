# frozen_string_literal: true

require "rails_helper"

RSpec.describe Note, type: :model do
  describe "validations" do
    subject { build(:note) }
    it { is_expected.to validate_presence_of(:study_date) }
    it { is_expected.to validate_numericality_of(:notebook_number).only_integer }
    it { is_expected.to validate_numericality_of(:notebook_page).only_integer }
  end
end

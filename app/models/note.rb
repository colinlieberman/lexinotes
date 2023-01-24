# frozen_string_literal: true

class Note < ApplicationRecord
  has_many :note_tags, inverse_of: :note
  has_many :tags, through: :note_tags, inverse_of: :notes

  has_many :note_citations, inverse_of: :note
  has_many :citations, through: :note_citations, inverse_of: :notes

  validates :study_date, presence: true
end

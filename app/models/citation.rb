# frozen_string_literal: true

class Citation < ApplicationRecord
  has_many :note_citations, inverse_of: :citation
  has_many :notes, through: :note_citations, inverse_of: :citations

  validates :book, presence: true

  validates :chapter, presence: true, numericality: { only_integer: true }

  validates :verse, presence: true, numericality: { only_integer: true }
end

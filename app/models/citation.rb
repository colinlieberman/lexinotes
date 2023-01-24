# frozen_string_literal: true

class Citation < ApplicationRecord
  has_many :note_citations, inverse_of: :citation
  has_many :notes, through: :note_citations, inverse_of: :citations

  validates :book, presence: true, uniqueness: { case_sensitive: false, scope: %i[chapter verse] }

  validates :chapter, presence: true, uniqueness: { case_sensitive: false, scope: %i[book verse] },
                      numericality: { only_integer: true }

  validates :verse, presence: true, uniqueness: { case_sensitive: false, scope: %i[book chapter] },
                    numericality: { only_integer: true }
end

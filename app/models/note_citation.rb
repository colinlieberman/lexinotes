# frozen_string_literal: true

class NoteCitation < ApplicationRecord
  belongs_to :note, inverse_of: :note_citations
  belongs_to :citation, inverse_of: :note_citations

  validates :note_id, presence: true, uniqueness: { scope: :citation_id }
  validates :citation_id, presence: true, uniqueness: { scope: :note_id }
end

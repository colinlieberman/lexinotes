# frozen_string_literal: true

class NoteTag < ApplicationRecord
  belongs_to :note, inverse_of: :note_tags
  belongs_to :tag, inverse_of: :note_tags

  validates :note_id, presence: true, uniqueness: { scope: :tag_id }
  validates :tag_id, presence: true, uniqueness: { scope: :note_id }
end

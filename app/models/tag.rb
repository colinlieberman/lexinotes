# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :note_tags, inverse_of: :tag
  has_many :notes, through: :note_tags, inverse_of: :tags

  validates :name, presence: true, uniqueness: true
end

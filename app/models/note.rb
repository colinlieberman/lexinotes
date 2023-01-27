# frozen_string_literal: true

class Note < ApplicationRecord
  has_many :note_tags, inverse_of: :note
  has_many :tags, through: :note_tags, inverse_of: :notes

  has_many :note_citations, inverse_of: :note
  has_many :citations, through: :note_citations, inverse_of: :notes

  validates :study_date, presence: true

  validates :notebook_number, numericality: { only_integer: true }
  validates :notebook_page, numericality: { only_integer: true }

  validates :active, presence: true

  scope :active, -> { where("notes.active" => true) }

  def citations_str
    citations.map { |c| "#{c.book} #{c.chapter}:#{c.verse}" }.uniq.join(",")
  end

  def tags_str
    tags.map(&:name).join(",")
  end

  def study_date_str
    study_date.strftime("%b %d %Y")
  end

  def to_json(arg = nil)
    json = JSON.parse(super(arg))
    json["study_date"] = study_date_str
    json["tags"] = tags_str
    json["citations"] = citations_str
    JSON.generate(json)
  end
end

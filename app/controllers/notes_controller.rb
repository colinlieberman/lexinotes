# frozen_string_literal: true

class NotesController < AuthenticatedController
  def index
    @notes = Note.active
  end
end
# frozen_string_literal: true

class NotesController < AuthenticatedController
  def index
    @notes = Note.active
  end

  def create
    response = create_response

    respond_to do |format|
      format.json { render json: response.to_json }
      format.html do
        # reload the index if this wasn't an xhr
        @notes = Note.active
        render :index
      end
    end
  end

  private

  def create_response
    note = Note.new(study_date: params[:study_date], content: params[:content])

    update_props(note)

    if note.save
      note.citations.push(citation_from_params)
      note
    else
      note.errors.messages
    end
  end

  def update_props(note)
    note.update(notebook_number: params[:notebook_number]) if params[:notebook_number].present?
    note.update(notebook_page: params[:notebook_page]) if params[:notebook_page].present?
  end

  def citation_from_params
    return unless params[:citation]

    citation_params = params[:citation]
    book = citation_params[:book]
    chapter = citation_params[:chapter]
    verse = citation_params[:verse]

    return unless book && chapter && verse

    citation = Citation.new(book: book, chapter: chapter, verse: verse)
    citation if citation.save
  end
end

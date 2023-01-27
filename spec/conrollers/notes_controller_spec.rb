# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotesController, type: :controller do
  describe "authentication" do
    it "redirects to login unless authenticated" do
      get :index
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, login_path).to_s)
    end
  end

  describe "creating notes" do
    render_views
    it "creates notes" do
      expect(Note.count).to eq(0)
      expect(Citation.count).to eq(0)

      # authenticate
      session[:good_until] = DateTime.now.to_i + 3600

      post :create, params: {
        study_date: "2023-02-01",
        "citation[book]": "asdf",
        "citation[chapter]": "32",
        "citation[verse]": "3",
        content: "adfafd",
        notebook_number: "3",
        notebook_page: "3"
      }

      expect(Note.count).to eq(1)
      expect(Note.count).to eq(1)
    end

    it "reports errors" do
      # authenticate
      session[:good_until] = DateTime.now.to_i + 3600

      request.headers["Accept"] = "application/json"

      post :create, params: {
        "citation[book]": "asdf",
        "citation[chapter]": "32",
        "citation[verse]": "3",
        notebook_number: "3",
        notebook_page: "3"
      }

      expect(JSON.parse(response.body)["study_date"]).to eq(["can't be blank"])
    end
  end
end

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
end

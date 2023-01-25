# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoginController, type: :controller do
  describe "authentication" do
    it "authenticates valid pw and redirects to notes index" do
      post :login, { params: { password: Rails.application.credentials.access_password } }
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, notes_path).to_s)
    end

    it "renders the prompt again on failure" do
      post :login, { params: { password: "marsupials" } }
      # 200 means no redirect, meaning we're still at login
      expect(response.status).to eq(200)
    end

    it "logs you out if session expired" do
      post :login, { params: { password: Rails.application.credentials.access_password } }
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, notes_path).to_s)

      session[:good_until] = DateTime.now.to_i - 1

      @controller = NotesController.new
      get :index
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, login_path).to_s)
    end

    it "gives you a new hour with each page load" do
      post :login, { params: { password: Rails.application.credentials.access_password } }
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, notes_path).to_s)

      orig_good_until = session[:good_until]

      @controller = NotesController.new
      get :index

      expect(session[:good_until]).to be > orig_good_until
    end

    it "can log out" do
      post :login, { params: { password: Rails.application.credentials.access_password } }
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, notes_path).to_s)

      get :logout
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, login_path).to_s)

      @controller = NotesController.new
      get :index
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, login_path).to_s)
    end
  end
end

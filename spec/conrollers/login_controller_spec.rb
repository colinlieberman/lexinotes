# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoginController, type: :controller do
  describe "authentication" do
    it "can authenticate" do
      post :login, { params: { password: Rails.credentials.password } }
      expect(response.status).to eq(302)
      expect(response.headers["Location"]).to eq(URI.join(root_url, notes_path).to_s)
    end
  end
end

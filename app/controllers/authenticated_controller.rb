# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    redirect_to(login_path) unless session_timestamp_valid?
  end

  def session_timestamp_valid?
    return false unless session[:good_until]
    return false unless DateTime.now.to_i < session[:good_until]

    session[:good_until] += 3600
    true
  end
end
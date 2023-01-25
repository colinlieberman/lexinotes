# frozen_string_literal: true

class LoginController < ApplicationController
  def prompt; end

  def login
    return render "login/prompt" unless validate_password

    set_session
    redirect_to notes_path
  end

  def logout
    session.delete :good_until
    flash.notice = "You have been logged out"
    redirect_to login_path
  end

  private

  def validate_password
    return true if password_sent == Rails.application.credentials.access_password

    flash.alert = "Incorrect password"
    false
  end

  def password_sent
    params.require :password
  end

  def set_session
    now = DateTime.now.to_i
    session[:good_until] = now + 3600
  end
end

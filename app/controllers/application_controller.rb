# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user

protected

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = Session.active.find_by(token: session[:token])
  end

  def current_user
    @current_user = current_session&.user
  end
end

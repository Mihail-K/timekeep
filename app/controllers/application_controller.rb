# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = Session.active.find_by(token: session[:token])
  end

  def current_user
    current_session&.user
  end

  helper_method :current_session
  helper_method :current_user
end

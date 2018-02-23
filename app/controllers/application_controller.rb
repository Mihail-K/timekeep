# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  around_action :set_time_zone_for_current_user, if: :current_user

  helper_method :current_session
  helper_method :current_user

  def current_session
    return @current_session if defined?(@current_session)
    @current_session = Session.active.find_by(token: session[:token])
  end

  def current_user
    current_session&.user
  end

private

  def set_time_zone_for_current_user
    Time.use_zone(current_user.time_zone) { yield }
  end
end

# frozen_string_literal: true
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_session&.user || reject_unauthorized_connection
    end

  private

    def current_session
      return @current_session if defined?(@current_session) || cookies.encrypted[:session_token].blank?
      @current_session = Session.active.find_by(token: cookies.encrypted[:session_token])
    end
  end
end

# frozen_string_literal: true
class SessionsController < ApplicationController
  before_action :redirect_when_signed_in, only: :new

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      cookies.encrypted[:session_token] = @session.token
      redirect_to user_events_url(@session.user)
    else
      render 'new'
    end
  end

  def destroy
    current_session.destroy
    cookies.encrypted[:session_token] = nil
    redirect_to new_session_url
  end

private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_when_signed_in
    redirect_to user_events_url(current_user) if current_user.present?
  end
end

# frozen_string_literal: true
class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      session[:token] = @session.token
      redirect_to user_events_url(@session.user)
    else
      render 'new'
    end
  end

  def destroy
    current_session.destroy
    redirect_to new_session_url
  end

private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

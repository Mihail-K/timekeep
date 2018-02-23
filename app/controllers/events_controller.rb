# frozen_string_literal: true
class EventsController < ApplicationController
  before_action :set_user, only: :index
  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = policy_scope(Event).includes(:user).where(user: @user).order(date: :desc, time: :desc)
    @events = @events.page(params[:page]).per(params[:count])
  end

  def new
    date   = Date.current
    time   = Time.current.strftime('%R')
    @event = authorize(Event).new(date: date, time: time)
  end

  def create
    @event = Event.new(permitted_attributes(Event))
    @event.user = current_user

    if authorize(@event).save
      redirect_to user_events_url(current_user)
    else
      render 'new'
    end
  end

  def edit
    authorize(@event)
  end

  def update
    if authorize(@event).update(permitted_attributes(Event))
      redirect_to user_events_url(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    authorize(@event).destroy
    redirect_to user_events_url(current_user)
  end

private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_event
    @event = Event.where(user: current_user).find(params[:id])
  end
end

# frozen_string_literal: true
class EventsController < ApplicationController
  before_action :set_user, only: :index
  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = Event.where(user: @user).order(date: :desc, time: :desc)
  end

  def new
    date   = Date.current.in_time_zone(current_user.time_zone)
    time   = Time.current.in_time_zone(current_user.time_zone).strftime('%R')
    @event = Event.new(date: date, time: time)
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      redirect_to events_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_url
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy

    redirect_to events_url
  end

private

  def event_params
    params.require(:event).permit(:date, :time, :description)
  end

  def set_user
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
  end

  def set_event
    @event = Event.where(user: current_user).find(params[:id])
  end
end

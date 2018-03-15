# frozen_string_literal: true
class RemindersChannel < ApplicationCable::Channel
  def subscribed
    stream_for(current_user)
    current_user.update(online: true)
  end

  def unsubscribed
    current_user.update(online: false)
  end
end

# frozen_string_literal: true
class ReminderService
  attr_reader :reminder

  def initialize(reminder)
    @reminder = reminder
  end

  def self.deliverable
    Reminder.not_deleted.joins(:user)
      .where(Reminder.arel_table[:datetime].lteq(Time.current))
      .where(delivered: false, users: { online: true })
      .order(time: :desc, date: :desc)
  end

  def self.deliver_all
    deliverable.find_each.map(&method(:new)).each(&:deliver)
  end

  def deliver
    RemindersChannel.broadcast_to(reminder.user, reminder)
    reminder.update(delivered: true)
  end
end

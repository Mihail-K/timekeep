# frozen_string_literal: true
namespace :reminders do
  desc 'Delivers all pending reminders'
  task deliver_all: :environment do
    ReminderService.deliver_all
  end
end

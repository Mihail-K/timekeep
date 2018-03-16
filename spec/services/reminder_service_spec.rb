# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ReminderService, type: :service do
  describe '.deliver' do
    let(:user) { double('User', id: 1) }
    let(:reminder) { double('Reminder', id: 1, user: user) }
    let(:service) { ReminderService.new(reminder) }

    subject { service.deliver }

    it 'broadcasts an event on the reminders channel to the user, and marks the reminder as delivered' do
      expect(reminder).to receive(:update).with(delivered: true)
      expect { subject }.to broadcast_to(user).from_channel(RemindersChannel).with(reminder.as_json)
    end
  end

  describe '.deliverable' do
    let(:user) { create(:user, online: true) }
    let(:reminder) { create(:reminder, user: user) }

    before(:each) do
      allow(Time).to receive(:current).and_return(reminder.datetime)
    end

    subject { ReminderService.deliverable }

    it 'includes reminders that are in the past and are yet to be delivered' do
      should include(reminder)
    end

    it "doesn't include deleted reminders" do
      reminder.destroy
      should_not include(reminder)
    end

    it "doesn't include delivered reminders" do
      reminder.update(delivered: true)
      should_not include(reminder)
    end

    it "doesn't include reminders that are in the future" do
      reminder.update(date: Time.current.tomorrow)
      should_not include(reminder)
    end

    it "doesn't include reminders for which the user isn't online" do
      user.update(online: false)
      should_not include(reminder)
    end
  end

  describe '.deliver_all' do
    let(:reminder) { create(:reminder) }

    before(:each) do
      allow(ReminderService).to receive(:deliverable).and_return(Reminder.where(id: reminder))
    end

    it 'delivers each deliverable reminder' do
      service = double('ReminderService')
      expect(ReminderService).to receive(:new).with(reminder).and_return(service)
      expect(service).to receive(:deliver)
      ReminderService.deliver_all
    end
  end
end

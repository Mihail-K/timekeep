# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ReminderPolicy do
  let(:user) { User.new }
  let(:reminder) { Reminder.new(user: user) }

  subject { described_class }

  permissions '.scope' do
    let!(:user) { create(:user) }
    let!(:reminder) { create(:reminder, user: user) }

    context 'when not logged in' do
      subject { Pundit.policy_scope(nil, Reminder) }

      it 'is empty' do
        should be_empty
      end
    end

    context 'when a user is signed in' do
      subject { Pundit.policy_scope(user, Reminder) }

      it 'includes reminders owned by the user' do
        should include(reminder)
      end

      it "doesn't include reminders owned by other users" do
        reminder.update(user: create(:user))
        should_not include(reminder)
      end

      it "doesn't include deleted reminders" do
        reminder.destroy
        should_not include(reminder)
      end
    end
  end

  permissions :show? do
    it "doesn't allow guests to view reminders" do
      should_not permit(nil, reminder)
    end

    it 'allows users to view their own reminders' do
      should permit(user, reminder)
    end

    it "doesn't allow users to view other users' reminders" do
      reminder.user = User.new
      should_not permit(user, reminder)
    end

    it "doesn't allow users to view deleted reminders" do
      reminder.deleted = true
      should_not permit(user, reminder)
    end
  end

  permissions :create? do
    it "doesn't allow guests to create reminders" do
      should_not permit(nil, Reminder)
    end

    it 'allows users to create reminders' do
      should permit(user, Reminder)
    end
  end

  permissions :update? do
    it "doesn't allow guests to edit reminders" do
      should_not permit(nil, reminder)
    end

    it 'allows users to edit their own reminders' do
      should permit(user, reminder)
    end

    it "doesn't allow users to edit other users' reminders" do
      reminder.user = User.new
      should_not permit(user, reminder)
    end

    it "doesn't allow users to edit deleted reminders" do
      reminder.deleted = true
      should_not permit(user, reminder)
    end
  end

  permissions :destroy? do
    it "doesn't allow guests to delete reminders" do
      should_not permit(nil, reminder)
    end

    it 'allows users to delete their own reminders' do
      should permit(user, reminder)
    end

    it "doesn't allow users to delete other users' reminders" do
      reminder.user = User.new
      should_not permit(user, reminder)
    end

    it "doesn't allow users to delete deleted reminders" do
      reminder.deleted = true
      should_not permit(user, reminder)
    end
  end
end

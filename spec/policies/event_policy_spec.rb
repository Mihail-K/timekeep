# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { User.new }
  let(:event) { Event.new(user: user) }

  subject { described_class }

  permissions '.scope' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }

    it 'includes events by default' do
      expect(Pundit.policy_scope(user, Event)).to include(event)
    end

    it "doesn't include deleted events" do
      event.destroy
      expect(Pundit.policy_scope(user, Event)).not_to include(event)
    end
  end

  permissions :create? do
    it "doesn't allow guests to create events" do
      should_not permit(nil, Event)
    end

    it 'allows users to create events' do
      should permit(user, Event)
    end
  end

  permissions :update? do
    it "doesn't allow guests to edit events" do
      should_not permit(nil, event)
    end

    it 'allows users to edit their own events' do
      should permit(user, event)
    end

    it "doesn't allow users to edit other events" do
      should_not permit(User.new, event)
    end
  end

  permissions :destroy? do
    it "doesn't allow guests to edit events" do
      should_not permit(nil, event)
    end

    it 'allows users to edit their own events' do
      should permit(user, event)
    end

    it "doesn't allow users to edit other events" do
      should_not permit(User.new, event)
    end
  end
end

# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             not null
#  date        :date             not null
#  start_time  :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE), not null
#  deleted_at  :datetime
#  end_time    :string
#  duration    :integer
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without a user' do
    subject.user = nil
    should be_invalid
  end

  it 'is invalid without a date' do
    subject.date = nil
    should be_invalid
  end

  it 'is invalid without a start time' do
    subject.start_time = nil
    should be_invalid
  end

  it 'is invalid when the end time is before the start time' do
    subject.start_time = '11:00'
    subject.end_time   = '10:30'
    should be_invalid
  end

  it 'is invalid without a description' do
    subject.description = nil
    should be_invalid
  end

  it 'sets the duration of the event when a start and end times are present' do
    subject.start_time = '11:00'
    subject.end_time   = '12:35'
    expect { subject.save }.to change { subject.duration }.to(95)
  end

  describe '.previous_event' do
    let(:event) { create(:event) }
    let(:previous) { create(:event, user: event.user, date: event.date, start_time: '11:00') }

    subject { event.send(:previous_event) }

    it 'returns the previous event from the same user, on the same date' do
      should eq(previous)
    end

    it "doesn't return events owned by a different user" do
      previous.update(user: create(:user))
      should_not eq(previous)
    end

    it "doesn't return events on a different date" do
      previous.update(date: event.date - 1.day)
      should_not eq(previous)
    end

    it "doesn't return events that are after the current one" do
      previous.update(start_time: '12:30')
      should_not eq(previous)
    end
  end

  it 'sets the end time on the previous event when the ends-previous flag is set' do
    subject.ends_previous = true
    previous = create(:event, user: subject.user, date: subject.date, start_time: '11:00')
    expect { subject.save }.to change { previous.reload.end_time }.to(subject.start_time)
  end
end

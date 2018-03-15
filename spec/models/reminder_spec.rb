# frozen_string_literal: true
# == Schema Information
#
# Table name: reminders
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  date             :date             not null
#  time             :string           not null
#  description      :text             not null
#  html_description :text             not null
#  text_description :text             not null
#  deleted          :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_reminders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  subject { build(:reminder) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without a date' do
    subject.date = nil
    should be_invalid
  end

  it 'is invalid without a time' do
    subject.time = nil
    should be_invalid
  end

  it 'is invalid without a description' do
    subject.description = nil
    should be_invalid
  end

  it 'is invalid when the description is longer than 1000 characters' do
    subject.description = '1' * 1001
    should be_invalid
  end
end

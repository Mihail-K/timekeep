# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             not null
#  occurred_at :date             not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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

  it 'is invalid without an occurrence timestamp' do
    subject.occurred_at = nil
    should be_invalid
  end
end

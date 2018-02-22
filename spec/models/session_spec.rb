# frozen_string_literal: true
# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  token      :string           not null
#  expires_at :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_expires_at  (expires_at)
#  index_sessions_on_token       (token) UNIQUE
#  index_sessions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { build(:session) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an email and a user' do
    subject.user = nil
    subject.email = nil
    should be_invalid
  end

  it 'is invalid without a password and a user' do
    subject.user = nil
    subject.password = nil
    should be_invalid
  end

  it 'sets a user from the credentials when saved' do
    subject.user.save
    subject.user = nil
    expect { subject.save }.to change { subject.user }.to be_present
  end
end

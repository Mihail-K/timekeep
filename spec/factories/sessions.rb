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

FactoryBot.define do
  factory :session do
    association :user, strategy: :build

    email { user&.email || Faker::Internet.email }
    password { user&.password || Faker::Internet.password }
  end
end

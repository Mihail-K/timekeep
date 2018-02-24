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

FactoryBot.define do
  factory :event do
    association :user, strategy: :build

    date { Date.current }
    start_time '12:00'
    description { Faker::Hipster.sentence }
  end
end

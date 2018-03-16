# frozen_string_literal: true
# == Schema Information
#
# Table name: reminders
#
#  id               :uuid             not null, primary key
#  user_id          :uuid             not null
#  date             :date             not null
#  time             :string           not null
#  datetime         :datetime         not null
#  description      :text             not null
#  html_description :text             not null
#  text_description :text             not null
#  delivered        :boolean          default(FALSE), not null
#  delivered_at     :datetime
#  deleted          :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#
# Indexes
#
#  index_reminders_on_datetime  (datetime)
#  index_reminders_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :reminder do
    association :user, strategy: :build

    date { Date.current.tomorrow }
    time '12:00'
    description { Faker::Hipster.sentence }
  end
end

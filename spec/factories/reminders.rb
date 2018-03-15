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

FactoryBot.define do
  factory :reminder do
    user nil
    date '2018-03-14'
    time 'MyString'
    description 'MyText'
    html_description 'MyText'
    text_description 'MyText'
    deleted false
    deleted_at '2018-03-14 14:36:08'
  end
end

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
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Event < ApplicationRecord
  include SoftDeletable

  belongs_to :user

  validates :date, presence: true, timeliness: { date: true }
  validates :start_time, presence: true, timeliness: { time: true }
  validates :end_time, timeliness: { allow_blank: true, time: true }
  validates :description, length: { maximum: 1000 }, presence: true
end

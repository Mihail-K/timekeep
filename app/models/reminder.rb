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

class Reminder < ApplicationRecord
  include HashTaggable
  include MarkdownRenderable
  include SoftDeletable

  belongs_to :user

  validates :date, :time, :description, presence: true
  validates :description, length: { maximum: 1000 }
  validates :date, timeliness: { date: true }
  validates :time, timeliness: { time: true }

  creates_hash_tags_from :description
  renders_markdown_from :description

  before_save :set_datetime, if: -> { date_changed? || time_changed? }
  before_save :set_delivered_at, if: -> { delivered_changed?(to: true) }

  def serializable_hash(options = {})
    options[:only] = %i[id date time description html_description text_description]
    super
  end

private

  def set_datetime
    self.datetime = ActiveSupport::TimeZone[user.time_zone].parse("#{date} #{time}")
  end

  def set_delivered_at
    self.delivered_at = Time.current
  end
end

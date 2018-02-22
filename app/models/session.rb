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

class Session < ApplicationRecord
  attribute :email, :string
  attribute :password, :string

  belongs_to :user, optional: true

  validates :email, :password, presence: { on: :create }

  before_create :set_user_from_credentials, if: -> { user.nil? }
  before_create :set_expires_at, if: -> { expires_at.nil? }
  before_create :set_token, if: -> { token.nil? }

private

  def set_user_from_credentials
    self.user = User.find_by(email: email)&.authenticate(password) || nil
    errors.add(:base, :could_not_login) && throw(:abort) if user.nil?
  end

  def set_expires_at
    self.expires_at = 3.months.from_now
  end

  def set_token
    self.token = SecureRandom.base58(32)
  end
end

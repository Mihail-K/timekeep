# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :citext           not null
#  password_digest :string           not null
#  first_name      :string
#  last_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  validates :email, length: { maximum: 120 }, presence: true, uniqueness: { if: :email_changed? }
  validates :first_name, :last_name, length: { maximum: 50 }

  has_secure_password
end

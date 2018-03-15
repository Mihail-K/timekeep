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
#  online          :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email("#{first_name}.#{last_name}.#{n}") }

    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end

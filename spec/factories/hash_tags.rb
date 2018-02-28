# frozen_string_literal: true
# == Schema Information
#
# Table name: hash_tags
#
#  id         :uuid             not null, primary key
#  author_id  :uuid             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hash_tags_on_author_id  (author_id)
#  index_hash_tags_on_name       (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#

FactoryBot.define do
  factory :hash_tag do
    association :author, factory: :user, strategy: :build
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
  end
end

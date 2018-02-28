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

class HashTag < ApplicationRecord
  HASH_TAG_FORMAT = /\A[\w\-]+\z/

  belongs_to :author, class_name: 'User'

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :name, uniqueness: { if: :name_changed? }, format: { with: HASH_TAG_FORMAT }

  before_validation :set_name_to_lowercase, if: :name_changed?

private

  def set_name_to_lowercase
    self.name = name&.downcase
  end
end

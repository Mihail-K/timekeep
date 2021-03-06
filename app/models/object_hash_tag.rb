# frozen_string_literal: true
# == Schema Information
#
# Table name: object_hash_tags
#
#  id                 :uuid             not null, primary key
#  hash_tag_id        :uuid             not null
#  hash_taggable_type :string           not null
#  hash_taggable_id   :uuid             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_object_hash_tags_on_hash_tag_id                    (hash_tag_id)
#  index_object_hash_tags_on_hash_tag_id_and_hash_taggable  (hash_tag_id,hash_taggable_type,hash_taggable_id) UNIQUE
#  index_object_hash_tags_on_hash_taggable                  (hash_taggable_type,hash_taggable_id)
#
# Foreign Keys
#
#  fk_rails_...  (hash_tag_id => hash_tags.id)
#

class ObjectHashTag < ApplicationRecord
  belongs_to :hash_tag
  belongs_to :hash_taggable, polymorphic: true
end

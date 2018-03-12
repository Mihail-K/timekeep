# frozen_string_literal: true
class CreateObjectHashTags < ActiveRecord::Migration[5.1]
  def change
    create_table :object_hash_tags, id: :uuid do |t|
      t.belongs_to  :hash_tag, foreign_key: true, null: false, type: :uuid
      t.belongs_to  :hash_taggable, polymorphic: true, null: false, type: :uuid,
                                    index: { name: 'index_object_hash_tags_on_hash_taggable' }
      t.index       %i[hash_tag_id hash_taggable_type hash_taggable_id],
                    name: 'index_object_hash_tags_on_hash_tag_id_and_hash_taggable',
                    unique: true
      t.timestamps  null: false
    end
  end
end

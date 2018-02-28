# frozen_string_literal: true
class CreateEventHashTags < ActiveRecord::Migration[5.1]
  def change
    create_table :event_hash_tags, id: :uuid do |t|
      t.belongs_to  :event, foreign_key: true, null: false, type: :uuid
      t.belongs_to  :hash_tag, foreign_key: true, null: false, type: :uuid
      t.index       %i[event_id hash_tag_id], unique: true
      t.timestamps  null: false
    end
  end
end

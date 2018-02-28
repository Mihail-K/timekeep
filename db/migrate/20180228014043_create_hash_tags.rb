# frozen_string_literal: true
class CreateHashTags < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_tags, id: :uuid do |t|
      t.belongs_to  :author, foreign_key: { to_table: :users }, null: false, type: :uuid
      t.string      :name, null: false, index: { unique: true }
      t.timestamps  null: false
    end
  end
end

# frozen_string_literal: true
class AddDeletedAndDeletedAtToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :deleted, :boolean, null: false, default: false
    add_column :events, :deleted_at, :timestamp
  end
end

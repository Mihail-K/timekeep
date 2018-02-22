# frozen_string_literal: true
class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions, id: :uuid do |t|
      t.belongs_to  :user, foreign_key: true, null: false, type: :uuid
      t.string      :token, null: false, index: { unique: true }
      t.timestamp   :expires_at, null: false, index: true
      t.timestamps  null: false
    end
  end
end

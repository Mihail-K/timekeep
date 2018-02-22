# frozen_string_literal: true
class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.belongs_to  :user, foreign_key: true, null: false, type: :uuid
      t.date        :occurred_at, null: false
      t.text        :description
      t.timestamps  null: false
    end
  end
end

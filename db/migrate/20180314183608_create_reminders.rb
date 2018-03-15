# frozen_string_literal: true
class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders, id: :uuid do |t|
      t.belongs_to  :user, foreign_key: true, null: false, type: :uuid
      t.date        :date, null: false
      t.string      :time, null: false
      t.text        :description, null: false
      t.text        :html_description, null: false
      t.text        :text_description, null: false
      t.boolean     :deleted, null: false, default: false
      t.timestamps  null: false
      t.timestamp   :deleted_at
    end
  end
end

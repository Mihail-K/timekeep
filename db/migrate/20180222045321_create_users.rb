# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.citext      :email, null: false, index: { unique: true }
      t.string      :password_digest, null: false
      t.string      :first_name
      t.string      :last_name
      t.timestamps  null: false
    end
  end
end

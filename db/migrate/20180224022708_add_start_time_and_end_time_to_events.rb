# frozen_string_literal: true
class AddStartTimeAndEndTimeToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :time, :start_time
    add_column :events, :end_time, :string
  end
end

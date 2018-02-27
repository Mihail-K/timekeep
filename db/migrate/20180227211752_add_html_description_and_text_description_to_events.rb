# frozen_string_literal: true
class AddHtmlDescriptionAndTextDescriptionToEvents < ActiveRecord::Migration[5.1]
  class Event < ApplicationRecord; end

  def change
    add_column :events, :html_description, :text
    add_column :events, :text_description, :text

    reversible do |dir|
      dir.up do
        Event.find_each do |event|
          markdown = MarkdownService.new(event.description)
          event.update(html_description: markdown.render_html, text_description: markdown.render_text)
        end
      end
    end

    change_column_null :events, :html_description, false
    change_column_null :events, :text_description, false
  end
end

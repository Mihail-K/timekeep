# frozen_string_literal: true
module Markdownable
  extend ActiveSupport::Concern

  class_methods do
    def renders_markdown_from(attribute)
      before_save(if: :"#{attribute}_changed?") do
        hash_tags = respond_to?(:hash_tags) ? self.hash_tags : nil
        markdown  = MarkdownService.new(send(attribute), hash_tags: hash_tags)

        self["html_#{attribute}"] = markdown.render_html
        self["text_#{attribute}"] = markdown.render_text
      end
    end
  end
end

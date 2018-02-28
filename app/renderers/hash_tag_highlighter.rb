# frozen_string_literal: true
class HashTagHighlighter < Redcarpet::Render::HTML
  def normal_text(text)
    HashTagService.new(text).hash_tag_positions.reverse_each do |position, hash_tag|
      text[position..position + hash_tag.name.length] = <<-HTML.strip
        <a class="hash-tag" data-id="#{hash_tag.id}">#{text[position..position + hash_tag.name.length]}</a>
      HTML
    end
    text
  end
end

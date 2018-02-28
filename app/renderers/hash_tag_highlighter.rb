# frozen_string_literal: true
class HashTagHighlighter < Redcarpet::Render::HTML
  def initialize(hash_tags: nil, **options)
    @hash_tags = hash_tags || []
    super(**options)
  end

  def postprocess(text)
    each_hash_tag do |hash_tag|
      text = text.gsub(/(##{hash_tag.name})/i, <<-HTML.strip)
        <a class="hash-tag" data-id="#{hash_tag.id}">\\1</a>
      HTML
    end
    text
  end

private

  def each_hash_tag(&block)
    @hash_tags.sort_by { |hash_tag| -hash_tag.name.length }.each(&block)
  end
end

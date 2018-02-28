# frozen_string_literal: true
class MarkdownService
  DEFAULT_OPTIONS = {
    autolink:            true,
    escape_html:         true,
    no_intra_emphasis:   true,
    prettify:            true,
    safe_links_only:     true,
    space_after_headers: true
  }.freeze

  attr_reader :input
  attr_reader :options

  def initialize(input, **options)
    @input   = input
    @options = DEFAULT_OPTIONS.merge(options)
  end

  def render_html
    input && html_renderer.render(input).strip
  end

  def render_text
    input && text_renderer.render(input).strip
  end

private

  def html_renderer
    @html_renderer ||= Redcarpet::Markdown.new(HashTagHighlighter, options)
  end

  def text_renderer
    require 'redcarpet/render_strip'
    @text_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::StripDown, options)
  end
end

# frozen_string_literal: true
class MarkdownService
  MARKDOWN_OPTIONS = {
    autolink:            true,
    no_intra_emphasis:   true,
    space_after_headers: true
  }.freeze

  RENDERER_OPTIONS = {
    hard_wrap:       true,
    escape_html:     true,
    prettify:        true,
    safe_links_only: true
  }.freeze

  attr_reader :input
  attr_reader :options

  def initialize(input, **options)
    @input   = input
    @options = options
  end

  def render_html
    input && html_renderer.render(input).strip
  end

  def render_text
    input && text_renderer.render(input).strip
  end

private

  def html_renderer
    renderer_options = RENDERER_OPTIONS.merge(options)
    @html_renderer ||= Redcarpet::Markdown.new(HashTagHighlighter.new(renderer_options), MARKDOWN_OPTIONS)
  end

  def text_renderer
    require 'redcarpet/render_strip'
    @text_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::StripDown, MARKDOWN_OPTIONS)
  end
end

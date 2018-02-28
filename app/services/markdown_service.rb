# frozen_string_literal: true
class MarkdownService
  attr_reader :input
  attr_reader :options

  def initialize(input, **options)
    @input   = input
    @options = default_options.merge(options)
  end

  def render_html
    input && html_renderer.render(input).strip
  end

  def render_text
    input && text_renderer.render(input).strip
  end

private

  def default_options
    { filter_html: true }
  end

  def html_renderer
    @html_renderer ||= Redcarpet::Markdown.new(HashTagHighlighter, options)
  end

  def text_renderer
    require 'redcarpet/render_strip'
    @text_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::StripDown, options)
  end
end

# frozen_string_literal: true
class HashTagService
  HASH_TAG_FORMAT = /#[\w\-]+/

  attr_reader :input
  attr_reader :author

  def initialize(input, author = nil)
    @input  = input
    @author = author
  end

  def hash_tags
    hash_tag_positions.values
  end

  def hash_tag_positions
    @hash_tag_positions ||= fragments
      .map { |position, fragment| [position, hash_tag_from_fragment(fragment)] }
      .reject { |_, hash_tag| hash_tag.nil? }.to_h
  end

private

  def fragments
    input.enum_for(:scan, HASH_TAG_FORMAT).map do |fragment|
      [Regexp.last_match.begin(0), fragment[1..-1]]
    end.to_h
  end

  def hash_tag_from_fragment(fragment)
    hash_tag = HashTag.find_or_create_by(name: fragment) { |tag| tag.author = author }
    hash_tag.persisted? ? hash_tag : nil
  end
end

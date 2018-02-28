# frozen_string_literal: true
class HashTagService
  HASH_TAG_FORMAT = /#[\w\-]+/

  attr_reader :author
  attr_reader :input

  def initialize(author, input)
    @author = author
    @input  = input
    @cache  = {}
  end

  def fragments
    @fragments ||= input.scan(HASH_TAG_FORMAT).map { |fragment| fragment[1..-1].downcase }.reject(&:blank?).uniq
  end

  def hash_tags
    @hash_tags ||= fragments.map { |fragment| hash_tag(fragment) }
  end

  def hash_tag(fragment)
    @cache[fragment] ||= hash_tag_for_fragment(fragment)
  end

private

  def hash_tag_for_fragment(fragment)
    HashTag.find_or_create_by!(name: fragment) { |tag| tag.author = author }
  rescue ActiveRecord::RecordInvalid
    nil
  end
end

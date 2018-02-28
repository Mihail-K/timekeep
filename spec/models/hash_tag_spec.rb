# frozen_string_literal: true
# == Schema Information
#
# Table name: hash_tags
#
#  id         :uuid             not null, primary key
#  author_id  :uuid             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hash_tags_on_author_id  (author_id)
#  index_hash_tags_on_name       (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#

require 'rails_helper'

RSpec.describe HashTag, type: :model do
  subject { build(:hash_tag) }

  it 'has a valid factory' do
    should be_valid
  end

  it 'is invalid without an author' do
    subject.author = nil
    should be_invalid
  end

  it 'is invalid without a name' do
    subject.name = nil
    should be_invalid
  end

  it "is invalid when it's shorter than 2 characters" do
    subject.name = 'a'
    should be_invalid
  end

  it "is invalid when it's longer than 50 characters" do
    subject.name = 'a' * 51
    should be_invalid
  end

  it 'is invalid when a hash-tag exists with the same name' do
    create(:hash_tag, name: subject.name)
    should be_invalid
  end

  it 'is invalid when the name is malformed' do
    subject.name = 'foo bar'
    should be_invalid
  end

  it 'converts the name to lowercase' do
    subject.name = 'FOO'
    expect { subject.validate }.to change { subject.name }.to('foo')
  end
end

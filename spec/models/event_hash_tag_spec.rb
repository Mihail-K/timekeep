# frozen_string_literal: true
# == Schema Information
#
# Table name: event_hash_tags
#
#  id          :uuid             not null, primary key
#  event_id    :uuid             not null
#  hash_tag_id :uuid             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_event_hash_tags_on_event_id                  (event_id)
#  index_event_hash_tags_on_event_id_and_hash_tag_id  (event_id,hash_tag_id) UNIQUE
#  index_event_hash_tags_on_hash_tag_id               (hash_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (hash_tag_id => hash_tags.id)
#

require 'rails_helper'

RSpec.describe EventHashTag, type: :model do
  subject { build(:event_hash_tag) }

  it 'has a valid factory' do
    should be_valid
  end
end

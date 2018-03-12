# frozen_string_literal: true
class MigrateEventHashTagsToObjectHashTags < ActiveRecord::Migration[5.1]
  def up
    execute(<<-SQL.squish)
      INSERT INTO
        object_hash_tags(hash_tag_id, hash_taggable_id, hash_taggable_type, created_at, updated_at)
      SELECT
        event_hash_tags.hash_tag_id,
        event_hash_tags.event_id,
        'Event',
        event_hash_tags.created_at,
        event_hash_tags.updated_at
      FROM
        event_hash_tags
      ON CONFLICT DO NOTHING
    SQL
  end

  def down
    execute(<<-SQL.squish)
      INSERT INTO
        event_hash_tags(hash_tag_id, event_id, created_at, updated_at)
      SELECT
        object_hash_tags.hash_tag_id,
        object_hash_tags.hash_taggable_id,
        object_hash_tags.created_at,
        object_hash_tags.updated_at
      FROM
        object_hash_tags
      WHERE
        object_hash_tags.hash_taggable_type = 'Event'
      ON CONFLICT DO NOTHING
    SQL
  end
end

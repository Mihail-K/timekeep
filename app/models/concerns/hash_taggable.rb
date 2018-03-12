# frozen_string_literal: true
module HashTaggable
  extend ActiveSupport::Concern

  included do
    has_many :object_hash_tags, as: :hash_taggable, inverse_of: :hash_taggable, dependent: :destroy
    has_many :hash_tags, through: :object_hash_tags
  end

  class_methods do
    def creates_hash_tags_from(attribute, user_attribute: :user)
      before_save(if: :"#{attribute}_changed?") do
        self.hash_tags = HashTagService.new(send(user_attribute), send(attribute)).hash_tags
      end
    end
  end
end

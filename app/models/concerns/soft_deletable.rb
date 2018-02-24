# frozen_string_literal: true
module SoftDeletable
  extend ActiveSupport::Concern

  included do
    before_save :set_deleted_at, if: -> { deleted_changed?(to: true) }

    scope :deleted,     -> { where(deleted: true)  }
    scope :not_deleted, -> { where(deleted: false) }
  end

  def destroy
    update(deleted: true)
  end

  def destroy!
    update!(deleted: true)
  end

private

  def set_deleted_at
    self.deleted_at = Time.current
  end
end

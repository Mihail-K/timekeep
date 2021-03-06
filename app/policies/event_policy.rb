# frozen_string_literal: true
class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    current_user.present?
  end

  def update?
    return false if record.deleted?
    current_user.present? && current_user == record.user
  end

  def close?
    update?
  end

  def destroy?
    return false if record.deleted?
    current_user.present? && current_user == record.user
  end

  def permitted_attributes
    %i[date start_time end_time description ends_previous]
  end

  class Scope < Scope
    def resolve
      scope.not_deleted
    end
  end
end

# frozen_string_literal: true
class ReminderPolicy < ApplicationPolicy
  alias reminder record

  def show?
    !reminder.deleted? && reminder.user == current_user
  end

  def create?
    current_user.present?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  class Scope < Scope
    def resolve
      return scope.none if current_user.nil?
      scope.not_deleted.where(user: current_user)
    end
  end
end

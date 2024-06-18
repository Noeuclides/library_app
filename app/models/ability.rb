# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:librarian)
      can :read, :librarian_dashboard
    else
      can :read, :member_dashboard
    end
  end
end

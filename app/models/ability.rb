# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:librarian)
      can :manage, Book
      can [:read, :update], Borrow
      can :read, :librarian_dashboard
      can :return, :book
    else
      can :read, Book
      can [:read, :create], Borrow
      can :read, :member_dashboard
    end
  end
end

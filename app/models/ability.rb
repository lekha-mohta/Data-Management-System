# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new
    # Users
    if user.get_role_number >= 0
      can :read, Build
      can :read, Cad
      can :read, Material
      can :read, Machine
    end

    # Students
    if user.get_role_number >= 1
      can :create, Build
      can :create, Cad
      can :create, Material

      can :update, Build
      can :update, Cad
      can :update, Material
    end

    # Staff
    if user.get_role_number >= 2
    end

    # Admin
    return unless user.get_role_number == 3

    can :read, Machine
    can :read, Group
    can :read, User

    can :create, Machine
    can :create, Group
    can :create, User

    can :update, Machine
    can :update, Group
    can :update, User

    can :destroy, Group

    can :manage, GroupUser
    can :manage, GroupBuild
    can :manage, GroupCad
    can :manage, GroupMachine
    can :manage, GroupMaterial

    can :manage, Parameter
    can :manage, MachineParameter
  end
end

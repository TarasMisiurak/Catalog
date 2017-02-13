class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :update, :destroy, to: :cud

    if user.admin?
        can :crud, :all
    elsif user.moderator?
        can :crud, Post
        can :crud, Comment
        can :crud, FavoritePost
        can :crud, Category
        can :read, :all
        cannot :manage, User
    elsif user.member?
        can :read, :all
        can :crud, Post, user_id: user.id
        can :crud, Comment, user_id: user.id
        can :crud, FavoritePost, user_id: user.id
        can :read, Category
        can :crud, User, user_id: user.id
        cannot :cud, Category
    else
        can :read, Post
    end
  end
end

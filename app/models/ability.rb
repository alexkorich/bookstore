class Ability
  include CanCan::Ability
  def initialize(user)
    if user
     if user.admin?  
        can :access, :rails_admin       # only allow admin users to access Rails Admin
        can :dashboard           
        can :manage, :all
      else
        can :manage, CreditCard, user_id:user.id
        can :manage, Order,      user_id:user.id
        can :manage, OrderItem,  :order => { :user_id => user.id }
        can :manage, Rating,     user_id:user.id
        can :manage, WishList,   user_id:user.id

        can :read,        Author
        can :read,        Book
        can :read,        Category
        can :read,        Rating
        can :read,        :order_checkout
        can :update,      :order_checkout
        can :add_to_cart, :home      
        can :bestsellers, :home
        can :index,       :home

    end
    else
      can :read, Category
      can :read, Book
      can :read, Author
      can :bestsellers, :home
      can :index, :home
  end
 
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
  end
end

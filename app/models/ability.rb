class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify
    
    if user.is_a?(Admin)
      # Permissões de ADMIN
      can :manage, :all

    elsif user.is_a?(Republica)
      # Permissões para REPÚBLICAS

      # can :modify, Republica do |republica|
      #   republica.try(:id) == user.id
      # end

      can :read, Republica

      can :index_exmoradores, Republica, id: user.id
      
      # Pode administrar os próprios MORADORES
      can :modify, Morador, republica: {id: user.id}

      # Pode ler os próprios moradores
      can :read, Morador, republica: {id: user.id}
      
    else
      # Permissões para CONVIDADOS
      can :read, Republica
      can :create, Republica
    end


    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

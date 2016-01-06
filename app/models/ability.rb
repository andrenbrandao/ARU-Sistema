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

      can :read, Republica, approved: true
      
      # Pode administrar os próprios MORADORES
      can :manage, Morador, republica: {id: user.id}

      # Pode ler os próprios moradores
      can :read, Morador, republica: {id: user.id}

      # Pode modificar o próprio contato
      can :manage, Contato, republica: {id: user.id}

      # Pode modificar as próprias redes sociais
      can :manage, SocialInformation, republica: {id: user.id}

      # Pode ativar ou desativar vagas
      can :update, Vaga, republica: {id: user.id}

      # Pode administrar Serviços
      can :manage, Servico, republica: {id: user.id}
      can :create, Servico
      can :manage, Categoria, republica: {id: user.id}
      can :manage, Comentario, republica: {id: user.id}
      can :create, Comentario
      can :read, Comentario

      can :send_reconfirmation, Republica

      can :read, Evento
      can :manage, Evento, open: true
    else
      # Permissões para CONVIDADOS
      can :read, Republica, approved: true
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

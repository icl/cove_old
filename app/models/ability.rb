class Ability
  include CanCan::Ability

  def initialize(user)
    user || = User.new
    
    if user.admin
      can :manage, :all
    end
    
    if !user.nda_signed
      cannot :read, :all
    end
  end
end

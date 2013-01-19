#encoding: utf-8

class Republica < ActiveRecord::Base
  # Numero de republicas por pagina
  self.per_page = 7

  mount_uploader :logotipo, LogotipoUploader
  before_validation :copy_email_to_republica
  before_save :titleize_moradores

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible :login
  has_many :moradores, :dependent => :destroy, :inverse_of => :republica


  accepts_nested_attributes_for :moradores, :allow_destroy => true

  attr_accessible :ano_de_fundacao, :descricao, :endereco, :nome, :logotipo, :approved
  attr_accessible :telefone, :tipo, :numero_de_moradores, :moradores_attributes

  TIPO_DE_REP = [ "Masculina", "Feminina", "Mista"]

  validates :nome, presence: true, uniqueness: { case_sensitive: false}
  validates :tipo, presence: true, inclusion: TIPO_DE_REP
  validates :ano_de_fundacao, presence: true
  validates :descricao, presence: true, length: {minimum: 100}
  validates :endereco, presence: true
  #validates :telefone, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validate :min_of_moradores
  validate :max_of_moradores
  validate :has_one_representante
  validates_confirmation_of :password

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def self.search(search)
    if search
      where('nome LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  private

  def copy_email_to_republica
  	self.moradores.reject(&:marked_for_destruction?).each do |f|
  		if f.representante == true
  			self.email = f.email
  		end
  	end
  end

  def titleize_moradores
    self.moradores.reject(&:marked_for_destruction?).each do |f|
      f.nome = f.nome.to_s.titleize
      f.sobrenome = f.sobrenome.to_s.titleize
    end
  end

  def min_of_moradores
  	if self.moradores.reject(&:marked_for_destruction?).length < 3
  		self.errors.add(:base, "República deve ter no mínimo 3 moradores")
  	end
  end

  def max_of_moradores
  	if self.moradores.reject(&:marked_for_destruction?).length > 20
  		self.errors.add(:base, "República possui mais de 20 moradores")
  	end
  end

  def has_one_representante
  	count = 0
  	self.moradores.reject(&:marked_for_destruction?).each do |f|
  		if f.representante == true
  			count += 1
  		end
  	end

  	if count == 0
  		self.errors.add(:base, "Selecione um representante")
  	end
  end


  def self.find_first_by_auth_conditions(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  		where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  	else
  		where(conditions).first
  	end
  end

	# function to handle user's login via email or username
	# def self.find_for_database_authentication(warden_conditions)
	# 	conditions = warden_conditions.dup
	# 	if login = conditions.delete(:login).downcase
	# 		where(conditions).where('$or' => [ {:username => /^#{Regexp.escape(login)}$/i}, {:email => /^#{Regexp.escape(login)}$/i} ]).first
	# 	else
	# 		where(conditions).first
	# 	end
	# end 

end

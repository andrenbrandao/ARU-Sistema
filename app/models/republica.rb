#encoding: utf-8

class Republica < ActiveRecord::Base
  # Numero de republicas por pagina
  self.per_page = 9

  mount_uploader :logotipo, LogotipoUploader
  before_validation :copy_email_to_republica
  before_save :titleize_moradores
  before_save :titleize_endereco
  after_create :generate_contato_social_vaga
  # before_save :titleize_curso

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible :login
  has_many :moradores, :dependent => :destroy, :inverse_of => :republica
  has_many :interreps_vencidos, :dependent => :destroy
  has_one :contato, :dependent => :destroy
  has_one :social_information, :dependent => :destroy
  has_one :vaga, :dependent => :destroy


  accepts_nested_attributes_for :moradores, :allow_destroy => true
  accepts_nested_attributes_for :interreps_vencidos, :allow_destroy => true, :reject_if => lambda { |a| a[:ano].blank?}

  attr_accessible :ano_de_fundacao, :descricao, :endereco, :numero, :nome, :logotipo, :approved
  attr_accessible :telefone, :tipo, :moradores_attributes
  attr_accessible :presente_reunioes, :interreps_vencidos_attributes ## Atributos de Gamefication

  TIPO_DE_REP = [ "Masculina", "Feminina", "Mista"]

  validates :nome, presence: true, uniqueness: { case_sensitive: false}
  validates :tipo, presence: true, inclusion: TIPO_DE_REP
  validates :ano_de_fundacao, presence: true
  validates :descricao, presence: true, length: {minimum: 100}
  validates :endereco, presence: true
  validates :numero, presence: true, numericality: {greater_than: 0}
  #validates :telefone, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  validates :email, uniqueness: {case_sensitive: false}

  validate :min_of_moradores
  validate :max_of_moradores
  validate :has_one_representante
  validate :uniqueness_of_email
  validate :check_email
  # validate :is_exmorador_valid?
  validates_confirmation_of :password


  def self.check_inactivity 
    @republica = Republica.where(approved: true)

    @republica.each do |republica|

      ## Se a Republica nao tiver feito login, usa-se a data do cadastro
      if republica.current_sign_in_at.present?
        last_login = republica.current_sign_in_at
      else
        last_login = republica.created_at
      end

      if (Time.now - last_login).to_i / 1.day >= 180
        if republica.update_attribute(:approved, 'false')
         # puts "Republica being disapproved... " + republica.nome
         RepublicaMailer.inactivity_email(republica).deliver
       end
     end
      # Quando faltar 7 dias para completar 6 meses, avisa com email
      if (Time.now - last_login + 7.days).to_i / 1.day == 180
       # puts "Sending warning... " + republica.nome
       RepublicaMailer.inactivity_warning_email(republica).deliver
     end 
   end
 end


  # Mostra os atributos se tiver algum
  def atributos
    valid = false
    if self.interreps_vencidos.any?
      valid = true

    elsif presente_reunioes == true
      valid = true
    end

    # elsif Time.now.year - ano_de_fundacao <= 1  
    #   valid = true
    # end

    valid
  end


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
      where('lower(nome) LIKE ?', "%#{search.downcase}%")
    else
      scoped
    end
  end
  
  def exmoradores
    self.moradores.where(exmorador: true)
  end

  private

  def generate_contato_social_vaga
    self.create_contato
    self.create_social_information
    self.create_vaga
  end

  def check_email
    if approved_changed? && approved_was == false && self.persisted?
      if !confirmed_at?
        self.errors.add(:base, "República não confirmou email.")
      end
    end 
  end

  def uniqueness_of_email
    if !self.new_record?
      @rep = Republica.find(:all, :conditions => ["id != ?", self.id])
    else
      @rep = Republica.all
    end
    count = 0
    @rep.each do |republica|
      if republica.email == email
        count += 1
      end
    end
    if count != 0
      self.errors.add(:base, 'O email do representante já está em uso')
    end
  end


  # # Verificação de tempo de vivência para ex-morador
  # def is_exmorador_valid?
  #   self.moradores.reject(&:marked_for_destruction?).each do |f|
  #     if f.exmorador == true
  #       if Time.now - f.created_at < 6.months
  #         self.errors.add(:base, "'#{f.nome + ' ' + f.sobrenome}' tem menos de 6 meses de vivência")  
  #       end   
  #     end
  #   end
  # end

  def copy_email_to_republica
   self.moradores.reject(&:marked_for_destruction?).reject(&:exmorador?).each do |f|
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

def titleize_curso
  self.moradores.reject(&:marked_for_destruction?).each do |f|
    f.curso = f.curso.to_s.titleize
  end
end

def min_of_moradores
 if self.moradores.reject( &:marked_for_destruction?).reject(&:exmorador?).length < 3
  self.errors.add(:base, "A república deve ter no mínimo 3 moradores.")
end
end

def max_of_moradores
 if self.moradores.reject(&:marked_for_destruction?).reject(&:exmorador?).length > 20
  self.errors.add(:base, "A república possui mais de 20 moradores.")
end
end

def has_one_representante
 count = 0
 self.moradores.reject(&:marked_for_destruction?).reject(&:exmorador?).each do |f|
  if f.representante == true
   count += 1
 end
end

if count == 0
  self.errors.add(:base, "A república não pode ficar sem representante.")
end
end

def titleize_endereco
  self.endereco = self.endereco.to_s.titleize
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

#encoding: utf-8

class Republica < ActiveRecord::Base

	before_validation :copy_email_to_republica

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  has_many :moradores, :dependent => :destroy, :inverse_of => :republica


  accepts_nested_attributes_for :moradores, :allow_destroy => true

  attr_accessible :ano_de_fundacao, :descricao, :endereco, :nome
  attr_accessible :telefone, :tipo, :numero_de_moradores, :moradores_attributes

  TIPO_DE_REP = [ "Masculina", "Feminina", "Mista"]

  validates :nome, presence: true, uniqueness: true
  validates :tipo, presence: true, inclusion: TIPO_DE_REP
  validates :ano_de_fundacao, presence: true
  validates :descricao, presence: true, length: {minimum: 140}
  validates :endereco, presence: true
	#validates :telefone, presence: true
	validates :username, presence: true, uniqueness: { case_sensitive: false }

	validate :min_of_moradores
	validate :max_of_moradores
	validate :has_one_representante


	private

	def copy_email_to_republica
		self.moradores.reject(&:marked_for_destruction?).each do |f|
			if f.representante == true
				self.email = f.email
			end
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

end

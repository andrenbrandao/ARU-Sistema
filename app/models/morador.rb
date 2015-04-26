#encoding: utf-8

class Morador < ActiveRecord::Base
	self.per_page = 9

	default_scope { where(exmorador: false) }
	scope :is_exmorador, where(exmorador: true) 

	before_save :set_data_de_saida
	
	belongs_to :republica, :inverse_of => :moradores
	validates :republica, presence: true

	has_many :evento_moradores, dependent: :destroy
    has_many :eventos, through: :evento_moradores

	attr_accessible :ano_de_ingresso, :curso, :nome, :ra, :republica_id, :sobrenome, :universidade
	attr_accessible :email, :celular, :representante, :apelido, :exmorador, :data_de_saida

	UNIVERSIDADE = [ "Unicamp", "PUC", "Facamp", "Outra" ]
	CURSO = [ "Arquitetura e Urbanismo", "Artes Cênicas", "Artes Visuais", "Ciência da Computação", "Ciências Biológicas", "Ciências do Esporte", "Ciências Econômicas", "Ciências Sociais", "Midialogia", "Dança", "Educação Física", "Enfermagem", "Engenharia Agrícola", "Engenharia Ambiental", "Engenharia Civil", "Engenharia de Alimentos", "Engenharia de Computação", "Engenharia de Controle e Automação", "Engenharia de Manufatura", "Engenharia de Produção", "Engenharia de Telecomunicações", "Engenharia Elétrica", "Engenharia Mecânica", "Engenharia Química", "Estatística", "Estudos Literários", "Farmácia", "Filosofia", "Física", "Fonoaudiologia", "Geografia", "Geologia", "Gestão de Comércio Internacional", "Gestão de Empresas", "Gestão de Políticas Públicas", "Gestão do Agronegócio", "História", "Letras", "Licenciatura Integrada Química/Física", "Linguística", "Matemática", "Medicina", "Música", "Nutrição", "Odontologia", "Pedagogia", "Química", "Sistemas de Informação", "Tecnologia em Construção de Edifícios", "Tecnologia em Análise e Desenvolvimento de Sistemas", "Tecnologia em Controle Ambiental", "Outro"]

	validates :nome, presence: true
	validates_format_of :nome, :sobrenome, :with => /^[^0-9`!@#\$%\^&*+_=]+$/
	validates :sobrenome, presence: true
	validates :universidade, presence: true, inclusion: UNIVERSIDADE
	validates :ra, uniqueness: true, numericality: {only_integer: true },
	length: {is: 6, message: 'RA inválido'}, :allow_blank => true, :if => :is_unicamp?
	validates :curso, presence: true
	validates :ano_de_ingresso, presence: true
	validates :email, presence: true, :if => :is_representante?
	validates :celular, presence: true, :if => :is_representante?
	validates :data_de_saida, presence: true, :if => :directly_added?

	validate :verify_data_de_saida, :if => :directly_added?

	
	def self.update_9digit(old_number, new_number) 
		@morador = Morador.where(celular: old_number)

		@morador.each do |morador|
			morador.update2_without_timestamping(:celular, new_number)
		end
	end

	def full_name
		"#{nome} #{sobrenome}"
	end

	private

	def verify_data_de_saida
		if !self.marked_for_destruction?
			if !self.data_de_saida?
				self.republica.errors.add(:base, "Preencha a data de saída do ex-morador '#{self.nome} #{self.sobrenome}'.")
			elsif self.data_de_saida.year < self.ano_de_ingresso
				self.republica.errors.add(:base, "A data de saída de um ex-morador não pode ser menor que o ano de ingresso.")
			end
		end
	end

	def set_data_de_saida
		if !self.marked_for_destruction?
			if self.exmorador_changed? && self.exmorador_was == false
				time = Time.now
				self.data_de_saida ||= time 
			end
		end
	end


	def is_unicamp?
		universidade == "Unicamp"
	end

	def is_representante?
		representante == true		
	end

	def is_exmorador?
		exmorador == true
	end

	def directly_added?
		self.exmorador == true && !self.persisted?
	end

end

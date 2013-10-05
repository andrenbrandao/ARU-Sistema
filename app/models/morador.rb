#encoding: utf-8

class Morador < ActiveRecord::Base
	belongs_to :republica, :inverse_of => :moradores
	validates :republica, presence: true

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

	
	def self.update_9digit(old_number, new_number) 
		@morador = Morador.where(celular: old_number)

		@morador.each do |morador|
			morador.update2_without_timestamping(:celular, new_number)
		end
	end

	private

	def is_unicamp?
		universidade == "Unicamp"
	end

	def is_representante?
		representante == true		
	end

end

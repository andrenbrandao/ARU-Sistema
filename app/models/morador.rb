#encoding: utf-8

class Morador < ActiveRecord::Base
	belongs_to :republica, :inverse_of => :moradores
	validates :republica, presence: true

	attr_accessible :ano_de_ingresso, :curso, :nome, :ra, :republica_id, :sobrenome, :universidade
	attr_accessible :email, :celular, :representante, :apelido

	UNIVERSIDADE = [ "Unicamp", "PUC", "Facamp", "Outra" ]
	CURSO = [ "Arquitetura e Urbanismo", "Artes Cênicas", "Artes Visuais", "Ciência da Computação", "Ciências Biológicas", "Ciências do Esporte", "Ciências Econômicas", "Ciências Sociais", "Midialogia", "Dança", "Educação Física", "Enfermagem", "Engenharia Agrícola", "Engenharia Ambiental", "Engenharia Civil", "Engenharia de Alimentos", "Engenharia de Computação", "Engenharia de Controle e Automação", "Engenharia de Manufatura", "Engenharia de Produção", "Engenharia de Telecomunicações", "Engenharia Elétrica", "Engenharia Mecânica", "Engenharia Química", "Estatística", "Estudos Literários", "Farmácia", "Filosofia", "Física", "Fonoaudiologia", "Geografia", "Geologia", "Gestão de Comércio Internacional", "Gestão de Empresas", "Gestão de Políticas Públicas", "Gestão do Agronegócio", "História", "Letras", "Licenciatura Integrada Química/Física", "Linguística", "Matemática", "Medicina", "Música", "Nutrição", "Odontologia", "Pedagogia", "Química", "Sistemas de Informação", "Tecnologia em Construção de Edifícios", "Tecnologia em Análise e Desenvolvimento de Sistemas", "Tecnologia em Controle Ambiental"]

	validates :nome, presence: true
	validates_format_of :nome, :sobrenome, :with => /^[^0-9`!@#\$%\^&*+_=]+$/
	validates :sobrenome, presence: true
	validates :universidade, presence: true, inclusion: UNIVERSIDADE
	validates :ra, presence: true, uniqueness: true, numericality: {only_integer: true },
			   length: {is: 6, message: 'RA inválido'}, :if => :is_unicamp?
	validates :curso, presence: true
	validates :ano_de_ingresso, presence: true
	validates :email, presence: true, :if => :is_representante?
	validates :celular, presence: true, :if => :is_representante?
	
private

	def is_unicamp?
		universidade == "Unicamp"
	end

	def is_representante?
		representante == true		
	end

end

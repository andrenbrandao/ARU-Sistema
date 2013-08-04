#encoding: utf-8

class RepublicaMailer < ActionMailer::Base
	default from: "cadastro@republicasunicamp.com.br",
			reply_to: 'contato@republicasunicamp.com.br'

	def welcome_email(republica)
		@republica = republica
		@url  = 'http://cadastroaru.herokuapp.com/login'
		mail(to: republica.email, subject: 'Aprovação de Cadastro')
	end

	def disapprove_email(republica)
		@republica = republica
		mail(to: republica.email, subject: 'Conta Desativada')
	end

	def novo_cadastro_email(republica)
		@republica = republica
		mail(to: 'contato@republicasunicamp.com.br', subject: 'Novo cadastro de República')		
	end

	def inactivity_email(republica)
		@republica = republica
		mail(to: republica.email, subject: 'Conta Desativada')
	end

	def inactivity_warning_email(republica)
		@republica = republica
		mail(to: republica.email, subject: 'Atualização de Cadastro')
	end
end

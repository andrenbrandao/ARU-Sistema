class RepublicaMailer < ActionMailer::Base
	default from: "contato@republicasunicamp.com.br"

	def welcome_email(republica)
		@republica = republica
		@url  = 'http://cadastroaru.herokuapp.com/login'
		mail(to: republica.email, subject: 'Welcome to My Awesome Site')
	end
end

#encoding: utf-8

task :modify_9digit => :environment do
	puts "Modificando telefones com 9º digito..."
	DDDs = ['11','12','13','14','15','16','17','18','19']
	Morador.all.each do |morador|
		if(morador.celular != '' && morador.celular != nil)
			celular = morador.celular
			puts "Morador: " + morador.nome + " " + morador.sobrenome
			puts "\tCelular: " + celular
			if( (celular[1..2].in?DDDs) && (celular.length == 14))
				puts "Numero deve ser modificado"
				old_number = celular.clone
				celular.insert(5, '9')
				puts "Fazendo update..."
				Morador.update_9digit(old_number, celular)
				puts "Numero novo: " + celular
			end
		end
	end
	puts "done."
end
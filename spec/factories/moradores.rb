# encoding: utf-8

FactoryGirl.define do
  factory :morador do
		  nome 'caio'
          sobrenome 'bruno silva'
          curso 'Engenharia de Computação'
          ano_de_ingresso 2011
          universidade 'Unicamp'
          ra '123456'
          representante true
          email 'teste@gmail.com'
          celular '(19) 91234-5678'
  end

end



# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Republica.destroy_all

Admin.destroy_all
Admin.create(username: 'admin', email: 'admin@teste.com.br', password: 'admin', password_confirmation: 'admin')

# Paidabartira
params = 
{ :republica => 
  {
    approved: true,
    presente_reunioes: true,
    nome: 'Paidabartira',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Masculina',
      ano_de_fundacao: 2007,
      endereco: 'Rua Teste',
      numero: 123,
      telefone: '(19) 1234-5678',
      username: 'paidabartira',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'caio',
          sobrenome: 'bruno silva',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2011,
          universidade: 'Unicamp',
          ra: '123456',
          representante: true,
          email: 'teste@gmail.com',
          celular: '(19) 91234-5678',
          _destroy: 'false',
          },
          '1' => {
            nome: 'joao',
            sobrenome: 'carvalho',
            curso: 'Engenharia de Computação',
            ano_de_ingresso: 2011,
            universidade: 'Unicamp',
            ra: '111222',
            representante: false,
            _destroy: 'false',
            },
            '2' => {
              nome: 'José',
              sobrenome: 'bruno',
              curso: 'Engenharia Civil',
              ano_de_ingresso: 2011,
              universidade: 'Unicamp',
              ra: '123454',
              representante: false,
              _destroy: 'false',
             }
            }
          }
        }

        Republica.create!(params[:republica])

# Goma dos Drão
params = 
{ :republica => 
  {
    approved: true,
    nome: 'Goma dos Drão',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
    tipo: 'Masculina',
    ano_de_fundacao: 2010,
    endereco: 'R. teste ',
    numero: 12859,
    telefone: '(19) 1234-5678',
    username: 'goma',
    password: 'secret123',
    password_confirmation: 'secret123',
    moradores_attributes: {
      '3' => {
        nome: 'eric',
        sobrenome: 'da silva',
        curso: 'Engenharia Química',
        ano_de_ingresso: 2011,
        universidade: 'Unicamp',
        ra: '113333',
        representante: true,
        email: 'eric@gmail.com',
        celular: '(19) 91234-5678',
        _destroy: 'false',
        },
        '4' => {
          nome: 'francesco',
          sobrenome: 'alves',
          curso: 'Engenharia Química',
          ano_de_ingresso: 2011,
          universidade: 'Unicamp',
          ra: '112341',
          representante: false,
          _destroy: 'false',
          },
          '5' => {
            nome: 'Gustavo',
            sobrenome: 'arruda',
            curso: 'Engenharia Civil',
            ano_de_ingresso: 2011,
            universidade: 'Unicamp',
            ra: '123417',
            representante: false,
            _destroy: 'false',
            },

          }
        }
      }

      Republica.create!(params[:republica])


#Kinder Rep
params = 
{ :republica => 
  {
    nome: 'Kinder Rep',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Feminina',
      ano_de_fundacao: 2005,
      endereco: 'R. da Republica',
      numero: 1111,
      telefone: '(19) 1268-1445',
      username: 'kinder',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '6' => {
          nome: 'Bruna',
          sobrenome: 'alberta',
          curso: 'Economia',
          ano_de_ingresso: 2010,
          universidade: 'Unicamp',
          ra: '100012',
          representante: true,
          email: 'bruna@gmail.com',
          celular: '(11) 99123-4567',
          _destroy: 'false',
          },
          '7' => {
            nome: 'Gina',
            sobrenome: 'Silva',
            curso: 'Jornalismo',
            ano_de_ingresso: 2010,
            universidade: 'Outra',
            ra: '',
            representante: false,
            _destroy: 'false',
            },
            '8' => {
              nome: 'Tatiane',
              sobrenome: 'Abraao',
              curso: 'Fonoaudiologia',
              ano_de_ingresso: 2010,
              universidade: 'Unicamp',
              ra: '100123',
              representante: false,
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])

# RepúlicaChaça
params = 
{ :republica => 
  {
    approved: true,
    nome: 'RepúblicaChaça',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Masculina',
      ano_de_fundacao: 2007,
      endereco: 'Rua Paulo',
      numero: 444,
      telefone: '(19) 1234-5678',
      username: 'chaca',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'andré',
          sobrenome: 'Soares Jardim',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2011,
          universidade: 'Unicamp',
          ra: '111212',
          representante: false,
          _destroy: 'false',
          },
          '1' => {
            nome: 'Gabriel',
            sobrenome: 'Marx',
            curso: 'Engenharia de Computação',
            ano_de_ingresso: 2011,
            universidade: 'Unicamp',
            ra: '060809',
            representante: true,
            email: 'gabriel@gmail.com',
            celular: '(19) 99982-5253',
            _destroy: 'false',
            },
            '2' => {
              nome: 'Getúlio',
              sobrenome: 'Vargas',
              curso: 'Engenharia Civil',
              ano_de_ingresso: 2011,
              universidade: 'Unicamp',
              ra: '145555',
              representante: false,
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])

# Subako de Kobra
params = 
{ :republica => 
  {
    approved: true,
    nome: 'Subako de Kobra',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Masculina',
      ano_de_fundacao: 2003,
      endereco: 'Rua Joao',
      numero: 4123,
      telefone: '(19) 2323-9898',
      username: 'subako',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'renan',
          sobrenome: 'Maciel',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2011,
          universidade: 'Outra',
          ra: '',
          representante: false,
          _destroy: 'false',
          },
          '1' => {
            nome: 'Eduardo',
            sobrenome: 'Carvalho',
            curso: 'Engenharia de Computação',
            ano_de_ingresso: 2011,
            universidade: 'Outra',
            ra: '',
            representante: false,
            _destroy: 'false',
            },
            '2' => {
              nome: 'Bruno',
              sobrenome: 'Mini',
              curso: 'Engenharia de Computação',
              ano_de_ingresso: 2006,
              universidade: 'Unicamp',
              ra: '067890',
              representante: true,
              email: 'bruno@gmail.com',
              celular: '(11) 98275-4000',
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])

# Reptil Durval
params = 
{ :republica => 
  {
    approved: true,
    nome: 'Reptil Durval',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Mista',
      ano_de_fundacao: 2007,
      endereco: 'Rua Luiz',
      numero: 1234,
      telefone: '(19) 4412-1242',
      username: 'reptil',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'renan',
          sobrenome: 'barbosa',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2009,
          universidade: 'Outra',
          ra: '',
          representante: false,
          _destroy: 'false',
          },
          '1' => {
            nome: 'Marcelo',
            sobrenome: 'Arruda',
            curso: 'Engenharia Agrícola',
            ano_de_ingresso: 2007,
            universidade: 'Outra',
            ra: '',
            representante: false,
            _destroy: 'false',
            },
            '2' => {
              nome: 'Fernanda',
              sobrenome: 'Massa',
              curso: 'Engenharia Agrícola',
              ano_de_ingresso: 2009,
              universidade: 'Unicamp',
              ra: '061728',
              representante: true,
              email: 'fernanda@gmail.com',
              celular: '(19) 98245-9809',
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])



# PQP
params = 
{ :republica => 
  {
    approved: true,
    nome: 'PQP',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Mista',
      ano_de_fundacao: 2009,
      endereco: 'Rua Abraao',
      numero: 4412,
      telefone: '(19) 1242-9624',
      username: 'pqp',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'renan',
          sobrenome: 'mayor',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2011,
          universidade: 'Outra',
          ra: '',
          representante: false,
          _destroy: 'false',
          },
          '1' => {
            nome: 'Eduardo',
            sobrenome: 'Cache',
            curso: 'Engenharia de Computação',
            ano_de_ingresso: 2013,
            universidade: 'Outra',
            ra: '',
            representante: false,
            _destroy: 'false',
            },
            '2' => {
              nome: 'andré',
              sobrenome: 'brat',
              curso: 'Ciências Econômicas',
              ano_de_ingresso: 2007,
              universidade: 'Unicamp',
              ra: '078787',
              representante: true,
              email: 'brat@gmail.com',
              celular: '(19) 99879-0909',
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])


# Cativeiro
params = 
{ :republica => 
  {
    approved: true,
    nome: 'Cativeiro',
    descricao: 
    %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.},
      tipo: 'Masculina',
      ano_de_fundacao: 2009,
      endereco: 'Rua Braga',
      numero: 1222,
      telefone: '(19) 1234-5678',
      username: 'cativeiro',
      password: 'secret123',
      password_confirmation: 'secret123',
      moradores_attributes: {
        '0' => {
          nome: 'renan',
          sobrenome: 'braga',
          curso: 'Engenharia de Computação',
          ano_de_ingresso: 2011,
          universidade: 'Outra',
          ra: '',
          representante: false,
          _destroy: 'false',
          },
          '1' => {
            nome: 'Eduardo',
            sobrenome: 'vinicius',
            curso: 'Engenharia de Computação',
            ano_de_ingresso: 2011,
            universidade: 'Outra',
            ra: '',
            representante: false,
            _destroy: 'false',
            },
            '2' => {
              nome: 'Flávio',
              sobrenome: 'gama',
              curso: 'Engenharia Química',
              ano_de_ingresso: 2008,
              universidade: 'Unicamp',
              ra: '098989',
              representante: true,
              email: 'flavio@gmail.com',
              celular: '(19) 99393-0909',
              _destroy: 'false',
              },

            }
          }
        }

        Republica.create!(params[:republica])
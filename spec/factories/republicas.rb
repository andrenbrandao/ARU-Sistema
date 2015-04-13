FactoryGirl.define do
  factory :republica do
    nome 'pdbt'
    approved true
    descricao     %{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id aliquet eros, et lacinia est. Morbi vitae libero odio. Proin rutrum accumsan purus, non pulvinar quam. Vestibulum pretium, lorem vel sollicitudin convallis, enim justo feugiat massa, eu scelerisque neque risus eget dolor. Sed congue nisl ac massa feugiat, ut congue diam tempus. Vivamus non quam semper, elementum sem sed, mollis elit.}
    tipo 'Masculina'
    ano_de_fundacao 2007
    endereco 'Rua teste'
    numero 123
    telefone '(19) 1234-5678'
    username 'paidabartira'
    password 'secret123'
    password_confirmation 'secret123'
  end

end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :evento do
  	nome 'InterReps'
  	ano 2014
  	open false
  end

  factory :invalid_evento, parent: :evento do
    nome nil
  end
end

class InterrepsVencido < ActiveRecord::Base
  belongs_to :republica

  attr_accessible :ano
end

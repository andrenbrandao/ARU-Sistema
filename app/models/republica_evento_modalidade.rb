class RepublicaEventoModalidade < ActiveRecord::Base
  belongs_to :republica
  belongs_to :evento_modalidade

  attr_accessible :republica_id, :evento_modalidade_id

  	validates :republica, presence: true
	validates :evento_modalidade_id, uniqueness: {scope: :republica_id}
	validates :evento_modalidade, presence: true
end

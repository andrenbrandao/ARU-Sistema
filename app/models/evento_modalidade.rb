class EventoModalidade < ActiveRecord::Base
  belongs_to :evento
  belongs_to :modalidade
  has_many :republica_evento_modalidades
  has_many :republicas, through: :republica_evento_modalidades
  # attr_accessible :title, :body

	validates :evento, presence: true
	validates :modalidade_id, uniqueness: {scope: :evento_id}
	validates :modalidade, presence: true

end

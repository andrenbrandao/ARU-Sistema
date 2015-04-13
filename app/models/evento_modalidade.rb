class EventoModalidade < ActiveRecord::Base
  belongs_to :evento
  belongs_to :modalidade
  # attr_accessible :title, :body

	validates :evento, presence: true
	validates :modalidade_id, uniqueness: {scope: :evento_id}
	validates :modalidade, presence: true

end

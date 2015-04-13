class EventoMorador < ActiveRecord::Base
  belongs_to :evento
  belongs_to :morador
  
  validates :evento, presence: true
  validates :morador_id, uniqueness: {scope: :evento_id}
  validates :morador, presence: true
end

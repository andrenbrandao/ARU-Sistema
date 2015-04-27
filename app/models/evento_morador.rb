class EventoMorador < ActiveRecord::Base
  belongs_to :evento
  belongs_to :morador
  # belongs_to :jogador, class_name: "Morador", :conditions => "jogador.exmorador = 't' OR jogador.exmorador = 'f'"

  attr_accessible :type_of_player

  validates :evento, presence: true
  validates :morador_id, uniqueness: {scope: :evento_id}
  validates :morador, presence: true
end

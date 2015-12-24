class EventoMorador < ActiveRecord::Base
  belongs_to :evento, inverse_of: :evento_moradores
  belongs_to :morador, inverse_of: :evento_moradores
  # belongs_to :jogador, class_name: "Morador", :conditions => "jogador.exmorador = 't' OR jogador.exmorador = 'f'"

  # type_of_player indica se true é exmorador, false indica morador
  attr_accessible :type_of_player

  validates :evento, presence: true
  validates :morador_id, uniqueness: {scope: :evento_id}
  validates :morador, presence: true
end

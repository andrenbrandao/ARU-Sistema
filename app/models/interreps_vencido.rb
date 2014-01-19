class InterrepsVencido < ActiveRecord::Base
  belongs_to :republica

  attr_accessible :ano

  validates :ano, presence: true, uniqueness: true, numericality: true, :allow_blank => true
  validates :republica, presence: true
end

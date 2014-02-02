class Categorization < ActiveRecord::Base
	belongs_to :categoria 
	belongs_to :servico
end

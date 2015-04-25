require 'rails_helper'

RSpec.describe RepublicaEventoModalidade, :type => :model do
	let(:republica) {
		republica = build(:republica)
	 	republica.moradores << build(:morador)
	 	republica.moradores << build(:morador)
	 	republica.moradores << build(:morador)
	 	republica.save
	 	republica
	}

	let(:modalidade) {
		modalidade = create(:modalidade)
	}

	let(:evento) {
		evento = create(:evento)
		evento.modalidades << modalidade
		evento
	}

	context 'registering a republica in a modalidade' do

		it 'should be able to select a modalidade' do
			em = EventoModalidade.where(modalidade_id: modalidade.id, evento_id: evento.id)
			expect{republica.evento_modalidades << em}.to_not raise_error
			expect(republica.evento_modalidades.first).to eq(em.first)
		end

		it 'should have unique modalidades in an event' do
			em = EventoModalidade.where(modalidade_id: modalidade.id, evento_id: evento.id)
			republica.evento_modalidades << em
			expect{republica.evento_modalidades << em}.to raise_error 
		end
	end
end

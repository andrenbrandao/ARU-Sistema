require 'rails_helper'

RSpec.describe EventoMorador, :type => :model do
	let(:republica) {
		republica = build(:republica)
	 	republica.moradores << build(:morador)
	 	republica.moradores << build(:morador)
	 	republica.moradores << build(:morador)
	 	republica.save
	 	republica
	}
	let(:evento) {
		evento = create(:evento)
	}

	context 'registering a morador in an evento' do

		it 'should be able to add moradores' do
			morador = republica.moradores.first
			evento.moradores << morador
			expect(evento.moradores.first).to eq(morador)
		end

		it 'should have unique moradores in an event' do
			morador = republica.moradores.first
			evento.moradores << morador
			expect{evento.moradores << morador}.to raise_error
		end

		it "should be able to get the republica from the moradores" do
			evento.moradores << republica.moradores.first
			expect(evento.moradores.first.republica).to eq(republica)
		end
	end
end

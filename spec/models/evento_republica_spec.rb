require 'rails_helper'

RSpec.describe EventoRepublica, :type => :model do
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

	context 'registering an agregado in an evento' do

		it 'should be able to add agregados' do
			ag = EventoRepublica.new(agregado: "Jose da Silva")
			ag.republica = republica
			ag.evento = evento
			expect{ag.save}.to_not raise_error
			expect(ag.agregado).to eq("Jose da Silva")
			expect(ag.republica).to eq(republica)
			expect(ag.evento).to eq(evento)
		end

		it 'should have unique agregados in an event' do
			ag = EventoRepublica.new(agregado: "Jose da Silva")
			ag.republica = republica
			ag.evento = evento
			ag.save
			ag2 = EventoRepublica.new(agregado: "Jose da Silva")
			ag2.republica = republica
			ag2.evento = evento
			expect(ag2).to_not be_valid  
		end
	end
end

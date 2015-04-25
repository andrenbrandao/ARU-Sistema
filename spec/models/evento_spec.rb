require 'rails_helper'

RSpec.describe Evento, :type => :model do
	it 'should have a valid factory' do
		expect(build(:evento)).to be_valid
	end

	it 'should require a nome' do
		expect(build(:evento, nome: nil)).to_not be_valid
	end

	it 'should require a ano' do
		expect(build(:evento, ano: nil)).to_not be_valid
	end

	it 'should have unique nome with year' do
		create(:evento, nome: 'abc', ano: 123)
		expect(build(:evento, nome: 'abc', ano: 123)).to_not be_valid 
	end

	it "should always start with subscriptions closed" do
		evento = create(:evento)
		expect(evento.open).to eq(false)
	end

	context 'creating an evento' do

		it 'should be able to add modalidades' do
			evento = create(:evento)
			modalidade = create(:modalidade)
			evento.modalidades << modalidade
			expect(evento.modalidades.first).to eq(modalidade)
		end

		it 'should have unique modalidades' do
			evento = create(:evento)
			modalidade = create(:modalidade)
			evento.modalidades << modalidade
			expect{evento.modalidades << modalidade}.to raise_error
		end
	end
end

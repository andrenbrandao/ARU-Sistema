require 'rails_helper'

RSpec.describe Modalidade, :type => :model do
	it 'should have a valid factory' do
		expect(build(:modalidade)).to be_valid
	end

	it 'should require a nome' do
		expect(build(:modalidade, nome: nil)).to_not be_valid
	end

	it 'should require a ano' do
		expect(build(:modalidade, tipo: nil)).to_not be_valid
	end

	it 'should have unique nome with year' do
		create(:modalidade, nome: 'abc', tipo: 'masc')
		expect(build(:modalidade, nome: 'abc', tipo: 'masc')).to_not be_valid 
	end

	# context 'creating an evento' do

	# 	it 'should have a related user (owner) on create' do
	# 		user = create(:user)
	# 		evento = create(:evento)
	# 		user.companies << evento
	# 		expect(evento.users.first).to eq(user)
	# 		expect(user.evento_users.first.access).to eq('owner')
	# 	end

	# 	it 'should have only one owner' do
	# 		user1 = create(:user)
	# 		user2 = create(:user)
	# 		evento = create(:evento)
	# 		user1.companies << evento
	# 		user2.companies << evento
	# 		expect(user1.evento_users.first.access).to eq('owner')
	# 		expect(user2.evento_users.first.access).to_not eq('owner')
	# 	end

	# 	it "should have a cheaper sponsorship package" do
	# 		Sponsorship.delete_all
	# 		create(:sponsorship, package: 'gold', level: 1)
	# 		sponsorship = create(:sponsorship, package: 'bronze', level: 4)
	# 		evento = create(:evento, sponsorship: nil)

	# 		expect(evento.sponsorship).to eq(sponsorship)
	# 	end
	# end
end

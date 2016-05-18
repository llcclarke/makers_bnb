feature 'sign up' do

  scenario 'user can sign up to BnB' do
		expect{sign_up}.to change(User, :count).by(1)
		expect(current_path).to eq('/')
	end

  scenario 'requires a matching confirmation password' do
    expect{ sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

end
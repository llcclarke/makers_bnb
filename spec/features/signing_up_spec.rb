feature 'sign up' do

  scenario 'user can sign up to BnB' do
		expect{sign_up}.to change(User, :count).by(1)
		expect(current_path).to eq('/')
	end

  scenario 'requires a matching confirmation password' do
    expect{ sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  scenario 'only unique usernames can sign up' do
  	sign_up(email: 'asd@asd.com')
  	expect{sign_up}.not_to change(User, :count)
  	expect(page).to have_content('Username is already taken')
  end

  scenario 'only unique emails can sign up' do
  	sign_up(username: 'asdf')
  	expect{sign_up}.not_to change(User, :count)
  	expect(page).to have_content('Email is already taken')
  end

end
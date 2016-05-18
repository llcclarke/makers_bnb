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

  scenario 'I cannot sign up with an invalid email' do
    expect{ sign_up(email: 'user@email') }.not_to change(User, :count)
  end

  scenario 'I cannot sign up without an email' do
    expect{ sign_up(email: nil)}.not_to change(User, :count)
  end

  scenario 'I cannot sign up without a username' do
    expect { sign_up(username: nil)}.not_to change(User, :count)
  end
  scenario 'I cannot sign up without a name' do
    expect { sign_up(name: nil)}.not_to change(User, :count)
  end

end
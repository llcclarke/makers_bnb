feature 'sign up' do
	scenario 'user can sign up to BnB' do
		expect{sign_up}.to change(User, :count).by(1)
		expect(current_path).to eq('/')
	end

	scenario 'Requires a matching confirmation' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq ('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'Email address must be filled in' do
    expect {sign_up email: nil}.to_not change(User, :count)
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'Email address must be valid' do
    expect {sign_up email: 'name@email'}.not_to change(User, :count)
    expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'Email must be unique' do
    sign_up
    expect {sign_up}.to_not change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end

  scenario 'Name must be filled in' do
    expect {sign_up name: nil}.to_not change(User, :count)
    expect(page).to have_content 'Name must not be blank'
  end

  scenario 'Username must be filled in' do
    expect {sign_up username: nil}.to_not change(User, :count)
    expect(page).to have_content 'Username must not be blank'
  end

  scenario 'Password must be filled in' do
    expect {sign_up password: nil}.to_not change(User, :count)
    expect(page).to have_content 'Password must not be blank'
  end

end

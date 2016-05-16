feature 'sign out' do
	scenario 'users who are signed in can sign out of Bnb' do
		sign_up
		sign_in
		expect(page).to have_button('sign out')
		click_button('sign out')
		expect(page).not_to have_content('welcome Joe Chin')
	end

	scenario 'users who are not signed in cannot sign out' do
		visit('/')
		expect(page).not_to have_button('sign out')
	end
end
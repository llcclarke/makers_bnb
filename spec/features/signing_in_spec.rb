feature 'signing in' do
	scenario 'a user can sign in after they have signed up' do
		sign_up
		sign_in
		expect(page).to have_content('welcome Joe Chin')
	end
end
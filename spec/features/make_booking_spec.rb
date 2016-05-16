feature 'making a booking' do

    scenario 'user can view an individual listing' do
       create_listing
       click_button 'Submit'
       click_link 'Cupboard underneath the stairs'
       expect(page).to have_button 'Request'

    end
end
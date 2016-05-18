feature 'making a booking' do

  before(:each) do
    sign_up
    sign_in
    create_listing2
    create_listing3
  end


    scenario 'user can view an individual listing' do
       visit '/listings'
       expect(page).to have_content 'Title1'
       expect(page).to have_content 'Title2'
       click_link 'Title1'
       expect(page).to have_content 'Description1'
       expect(page).to_not have_content 'Description2'
    end

    scenario 'view multiple listings' do
      visit '/listings'
      expect(page).to have_content 'Title1'
      expect(page).to have_content 'Title2'
    end

    scenario 'has a request button' do
        visit '/listings'
        click_link 'Title1'
        expect(page).to have_button 'Request Booking'
    end

    scenario 'requesting a booking changes availability' do
      visit '/listings'
      click_link 'Title1'
      click_button 'Request Booking'
      visit '/listings'
      click_link 'Title1'
      expect(page).to have_content 'Availability: No vacancy'
    end


    scenario 'requesting a booking returns a confirmation page' do
      visit '/listings'
      click_link 'Title1'
      click_button 'Request Booking'
      expect(page.status_code).to eq 200
      expect(page).to have_content 'You have successfully booked'
    end
end

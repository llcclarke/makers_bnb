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

    xscenario 'requesting a booking changes availability' do
      visit '/listings'
      click_link 'Title1'
      click_button 'Request Booking'
      make_booking
      click_button 'Submit'
      visit '/listings'
      click_link 'Title1'
      expect(page).to have_content 'Availability: No vacancy'
    end


    scenario 'requesting a booking returns a confirmation page' do
      visit '/listings'
      click_link 'Title1'
      click_button 'Request Booking'
      make_booking
      expect(page.status_code).to eq 200
      expect(page).to have_content 'You have successfully booked'
    end

    scenario 'has a booking page' do
    visit '/bookings/new'
    expect(page).to have_content 'Check in date'
    expect(page).to have_content 'Check out date'
    expect(page).to have_button 'Request'
    end

    scenario 'cannont book a date in the past' do
      visit '/bookings/new'
      fill_in 'check_in_date', with: '17/04/1984'
      fill_in 'check_out_date', with: '18/04/1984'
      click_button 'Request'
      expect(page).to have_content 'Are you a time traveller?'

    end

end

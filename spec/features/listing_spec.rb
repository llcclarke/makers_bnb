feature 'Viewing listings' do

  before(:each) do
    sign_up
    sign_in
    create_listing2
    create_listing3


  end

    scenario 'can view dates that are not available' do
      visit '/listings'
      click_link 'Title1'
      click_button 'Request Booking'
      make_booking
      click_button 'Submit'
      visit '/listings'
      click_link 'Title1'
      expect(page).to have_content 'Unavailable dates'
      expect(page).to have_content '10/10/2016 - 20/10/2016'
    end
  end

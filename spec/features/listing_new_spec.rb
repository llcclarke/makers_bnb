feature 'Create new listing' do

  scenario 'only list space if signed in' do
    sign_out
    visit '/listings/new'
    expect(current_path).to eq '/'
    expect(page).to have_content 'You must be signed in to post a new listing'
    sign_up
    sign_in
    visit '/listings/new'
    expect(page).to have_content 'List a new space'
  end

  before :each do
    sign_up
    sign_in
  end

  scenario 'has new listing page' do
    visit '/listings/new'
    expect(page.status_code).to eq (200)
    expect(page).to have_content 'List a new space'
    expect(page).to have_content 'Title:'
    expect(page).to have_content 'Description:'
    expect(page).to have_content 'Price:'
    expect(page).to have_button  'Submit'
  end

  scenario 'shows a new listing on the listings page' do
    create_listing
    click_button 'Submit'
    expect(current_path).to eq '/listings'
    expect(page).to have_content 'Cupboard underneath the stairs'
  end

  scenario 'increases the listing db count by one' do
create_listing
    expect{click_button 'Submit'}.to change(Listing, :count).by(1)
  end

  xscenario 'starts as available' do
    create_listing
    click_button 'Submit'
    expect(page).to have_content 'Availability: Available now'
  end


end

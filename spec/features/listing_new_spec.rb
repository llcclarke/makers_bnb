feature 'Create new listing' do

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
    visit '/listings/new'
    fill_in 'title', with: 'Cupboard underneath the stairs'
    fill_in 'description', with: 'Suitable for one small nephew'
    fill_in 'price', with: 666
    click_button 'Submit'
    expect(current_path).to eq '/listings'
    expect(page).to have_content 'Cupboard underneath the stairs'
  end

  scenario 'increases the listing db count by one' do
    visit '/listings/new'
    fill_in 'title', with: 'Cupboard underneath the stairs'
    fill_in 'description', with: 'Suitable for one small nephew'
    fill_in 'price', with: 666
    expect{click_button 'Submit'}.to change(Listing, :count).by(1)
  end

  scenario 'starts as available' do
    visit '/listings/new'
    fill_in 'title', with: 'Cupboard underneath the stairs'
    fill_in 'description', with: 'Suitable for one small nephew'
    fill_in 'price', with: 666
    click_button 'Submit'
    expect(page).to have_content 'Availability: Available now'
  end

end

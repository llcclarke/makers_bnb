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

end
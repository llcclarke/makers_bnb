

def create_listing
    visit '/listings/new'
    fill_in 'title', with: 'Cupboard underneath the stairs'
    fill_in 'description', with: 'Suitable for one small nephew'
    fill_in 'price', with: 666
  end
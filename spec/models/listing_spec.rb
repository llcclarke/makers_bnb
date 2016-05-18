require './app/models/listing'

describe 'listing' do
  subject(:listing) {Listing.create(title: 'Title1', description: 'Description1', price: 20)}
  describe '#availability' do
    xit 'starts available' do
      expect(subject.is_available).to be_truthy
    end
  end
end

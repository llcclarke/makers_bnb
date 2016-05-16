require './app/models/listing'

describe 'listing' do
  describe '#availability' do
    it 'starts available' do
      expect(subject.availability).to be_true
    end
  end
end

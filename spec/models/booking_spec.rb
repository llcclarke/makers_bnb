require './app/models/booking.rb'
describe 'Booking' do
describe '#check_date' do
  it 'returns false when given a date in the past' do
    expect(Booking.check_date('17/04/1984')).to be_falsey
    end
  end
end

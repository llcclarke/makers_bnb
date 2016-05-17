require './app/models/booking.rb'
describe 'Booking' do
subject(:booking){Booking.create(start_date: 17/04/2016, end_date: 18/04/2016 )}
describe '#check_date' do
  it 'returns false when given a date in the past' do
    expect{booking.check_date(17/04/1984)}.to be_falsey
    end
  end
end

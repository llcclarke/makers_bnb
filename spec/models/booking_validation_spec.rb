require 'booking_validation'
describe 'Booking' do
  describe '#check_date' do
    it 'returns false when given a date in the past' do
      expect(BookingValidation.new.check_date('17/04/1984')).to be_falsey
    end
    it 'returns true when given a date in the future' do
      expect(BookingValidation.new.check_date('09/11/2911')).to be_truthy
    end
  end
  describe "#date_comparison" do
    it 'returns false if check-in date is after check out-date' do
      expect(BookingValidation.new.date_comparison('20/04/2016','17/04/2016')).to be_falsey
    end
    it 'returns true if check-in date is before check-out date' do
      expect(BookingValidation.new.date_comparison('17/04/2016','20/04/2016')).to be_truthy
    end
  end
end

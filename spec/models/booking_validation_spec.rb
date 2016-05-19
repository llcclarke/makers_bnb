require 'booking_validation'
describe 'Booking' do
  let(:booking_val) { BookingValidation.new }
  describe '#check_date?' do
    it 'returns false when given a date in the past' do
      expect(booking_val.check_date?('17/04/1984')).to be_falsey
    end
    it 'returns true when given a date in the future' do
      expect(booking_val.check_date?('09/11/2911')).to be_truthy
    end
  end
  describe "#date_comparison?" do
    it 'returns false if check-in date is after check out-date' do
      expect(booking_val.date_comparison?('20/04/2016','17/04/2016')).to be_falsey
    end
    it 'returns true if check-in date is before check-out date' do
      expect(booking_val.date_comparison?('17/04/2016','20/04/2016')).to be_truthy
    end
  end
  describe "#date_valid?" do
    it 'returns true if check-in date is before check-out date of other guest' do
      expect(booking_val.date_valid?('17/04/2016','20/04/2016','21/04/2016','24/04/2016')).to be_truthy
    end
    it 'returns true if check-out date of other guest is after check-in date' do
      expect(booking_val.date_valid?('17/04/2016','20/04/2016','15/04/2016','16/04/2016')).to be_truthy
    end
  end
  describe "#right_order?" do
    it 'returns true if the check-in date is before the check-out date' do
      expect(booking_val.right_order?('17/04/2016','20/04/2016')).to be_truthy
    end
    it 'returns false if the check-in date is after the check-out date' do
      expect(booking_val.right_order?('20/04/2016','17/04/2016')).to be_falsey
    end
  end
  describe "#super_check?" do
    it 'returns true if all the guard clauses are avoided' do
      expect(booking_val.super_check?('17/12/2016','20/12/2016')).to be_truthy
    end
  end
end

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
  describe "#listing_loop" do
    let(:all_listings) { [listing1, listing2] }
    let(:listing1)     { double(:listing, bookings: [booking1, booking2]) }
    let(:listing2)     { double(:listing, bookings: [booking3]) }
    let(:booking1)     { double(:booking, check_in_date: '10/12/2016', check_out_date: '11/12/2016') }
    let(:booking2)     { double(:booking, check_in_date: '14/12/2016', check_out_date: '15/12/2016') }
    let(:booking3)     { double(:booking, check_in_date: '11/12/2016', check_out_date: '15/12/2016') }
    it 'returns the dates that are available for the dates searched' do
      expect(booking_val.listing_loop('12/12/2016','13/12/2016',all_listings)).to eq([listing1])
    end
  end
end

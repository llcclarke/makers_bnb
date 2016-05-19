class BookingValidation

    def check_date?(date)
      today_date = DateTime.now
      date_to_check = Date.parse(date)
      date_to_check >= today_date
    end

    def date_comparison?(start,finish)
      start_check = Date.parse(start)
      finish_check = Date.parse(finish)
      start_check <= finish_check
    end

    def date_valid?(new_start, new_end, check_start, check_end)
      check_start > new_end || check_end < new_start
    end

    def right_order?(new_start, new_end)
      new_end > new_start
    end

    def super_check?(new_start, new_end)
      check_date?(new_start) && right_order?(new_start, new_end)
    end

    def validation_loop(new_start, new_end, all_bookings)
      arr = []
      all_bookings.each do |booking|
        arr << date_valid?(new_start, new_end, booking.check_in_date, booking.check_out_date)
      end
      !arr.include? false
    end
end
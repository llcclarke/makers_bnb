class BookingValidation

    def check_date(date)
      today_date = DateTime.now
      date_to_check = Date.parse(date)
      date_to_check >= today_date
    end
    def date_comparison (start,finish)
      start_check = Date.parse(start)
      finish_check = Date.parse(finish)
      start_check <= finish_check
    end
end

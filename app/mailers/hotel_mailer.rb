class HotelMailer <  ActionMailer::Base
   default from: 'swapnil.b009@gmail.com'

  def guest_details(guest, reservation_details)
    @user = guest
    @reservation_details = reservation_details
    #@password = password
    mail(to: @reservation_details.hotel.email, subject: 'Guest Details')
  end
 
  def updated_guest_details(guest, reservation_details)
    @user = guest
    @reservation_details = reservation_details
    #@password = password
    mail(to: @reservation_details.hotel.email, subject: 'Reservation Successfull')
  end
end

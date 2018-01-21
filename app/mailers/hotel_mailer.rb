class HotelMailer <  ActionMailer::Base
 
  def guest_details(guest)
    @user = guest
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Guest Details')
  end
 
  def updated_guest_details(guest, reservation_details)
    @user = guest
    @reservation_details = reservation_details
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Reservation Successfull')
  end
end

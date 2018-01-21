class HotelMailer <  ActionMailer::Base
   default from: 'swapnil.b009@gmail.com'

  def guest_details(guest)
    @user = guest
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Guest Details')
  end
 
  def updated_guest_details(guest, reservation_details)
    @user = guest
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Reservation Successfull')
  end
end

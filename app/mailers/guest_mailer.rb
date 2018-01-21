class GuestMailer <  ActionMailer::Base
 
  def reservation_details(guest, reservation_details)
    @user = guest
    @reservation_details = reservation_details
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Reservation Successfull')
  end

  def updated_reservation_details(guest, reservation_details)
    @user = guest
    @reservation_details = reservation_details
    #@password = password
    mail(to: 'swapnil.m.bhosale@gmail.com', subject: 'Reservation Successfull')
  end

end

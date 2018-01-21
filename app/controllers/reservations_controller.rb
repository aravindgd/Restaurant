class ReservationsController < ApplicationController
	before_action :set_hotel_seat, :set_guest, except: [:index]
  before_action :set_reservation, only: [:update]
  
	def index
    @hotel = Hotel.find(params[:hotel_id])
    @reservations = @hotel.reservations
  rescue ActiveRecord::RecordNotFound
    render json: { status: 400 , message: ' Hotel Not Found'} 
  end


  def create
		if reservation_available?(matched_shift_time, match_guest_count)
      @reservation = Reservation.new(reservation_params)
      if @reservation.save 
        GuestMailer.reservation_details(@guest, @reservation).deliver_now
      	HotelMailer.guest_details(@guest).deliver_now
        render json: { status: 200, data: @reservation }
      else
      	render json: { created: false, errors: @reservation.errors.full_messages }
      end	
    else
    	render json: { created: false, message: message_seat_not_avail }
    end
	end
 
 def update
    if reservation_available?(matched_shift_time, match_guest_count)
      modify_reservation_attributes(params)
        if @reservation.save!     
          GuestMailer.updated_reservation_details(@guest, @reservation).deliver_now
          HotelMailer.updated_guest_details(@guest)
          render json: { status: 200, data: @reservation }
        else
          render json: { created: false, errors: @reservation.errors.full_messages }
        end
   else
      render json: { created: false, message: message_seat_not_avail }
   end 
 end
 
private
   
  def modify_reservation_attributes(params)
    booking_date = params[:reservations][:booking_day]
    guest_count = params[:reservations][:guest_count]
    if @reservation.booking_day_updated.blank? && @reservation.guest_count_updated.blank?
      @reservation.booking_day_updated = booking_date
      @reservation.guest_count_updated = guest_count
    else
      unless @reservation.booking_day_updated == booking_date 
        @reservation.booking_day = @reservation.booking_day_updated
        @reservation.booking_day_updated = booking_date       
      end
      unless @reservation.guest_count_updated == guest_count
        @reservation.guest_count = @reservation.guest_count_updated
        @reservation.guest_count_updated = guest_count
      end
    end
  end 

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

	def set_hotel_seat
   @hotel_seat = HotelSeat.find(params[:reservations][:hotel_seat_id])
	 rescue ActiveRecord::RecordNotFound
    render json: { status: 400 , message: ' Hotel Seat Not Found'} 
  end
  
  def match_guest_count 
	  guest_count = params[:reservations][:guest_count]
	  guest_count.between? @hotel_seat.minimum_seats, @hotel_seat.maximum_seats 
	end

  def matched_shift_time
  	@booking_date = params[:reservations][:booking_day].to_time
  	check_shift?(@hotel_seat.hotel.working_shifts, @booking_date)
  end

  def reservation_available?(matched_shift_time, match_guest_count)
  	if check_reserved? 
  		false
  	else
  	 match_guest_count && matched_shift_time ? true : false
  	end
  end
  
  def set_guest
    @guest = Guest.find(params[:guest_id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: 400 , message: ' Hotel Seat Not Found'} 
  end

  def message_seat_not_avail
  	if check_reserved?
  	  "Table is already booked for the day" 
  	elsif match_guest_count
  		"Please check the shift timings of the restaurant"
  	else
  		"Please check the number of seats accomodated in the table"
  	end
  end

  def check_reserved?
  	shifts = @hotel_seat.hotel.working_shifts
	  reservations = @hotel_seat.reservations.where('booking_day BETWEEN ? AND ?', @booking_date.beginning_of_day, @booking_date.end_of_day )
    if reservations.present?
    	shifts = reservations.map { |reservation| check_shift_reservation?(shifts, reservation.booking_day)}
    	check_shift?(shifts.flatten.uniq, @booking_date)
     end 
	end 

  def check_shift_reservation?(list, booking_time)
		list.select { |shift| booking_time.hour.between? shift.start_time.to_time.hour, shift.end_time.to_time.hour }
  end

	def check_shift?(list, booking_time)
		list.any? { |shift| booking_time.hour.between? shift.start_time.to_time.hour, shift.end_time.to_time.hour }
	end

  def reservation_params
    required_params = params.require(:reservations).permit(:name, :guest_count, :booking_day,:guest_id, :hotel_seat_id)
    required_params.merge!(guest_id: params[:guest_id], hotel_id: params[:hotel_id])
  end
end

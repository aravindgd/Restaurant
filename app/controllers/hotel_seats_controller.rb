class HotelSeatsController < ApplicationController
 before_action :set_hotel
  def create_hotel_seat
   @table = @hotel.hotel_seats.new(seat_params)
   if @table.save
   		render json: { status: 200, data: @table}
   else
   		render json: { created: false, errors: @table.errors.full_messages }
   end
		
	end

	def set_hotel
  	@hotel = Hotel.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { status: 400, message: ' Hotel Not Found'} 
  end

  def seat_params
   	params.require(:hotel_seats).permit(:name, :minimum_seats, :maximum_seats)
  end
end

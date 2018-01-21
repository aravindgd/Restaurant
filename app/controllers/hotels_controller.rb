class HotelsController < ApplicationController
 
  def create
		@hotel = Hotel.new(hotel_params)
		if @hotel.save
			 render json: { status: 200, data: @hotel }
		else
			 render json: { created: false, errors: @hotel.errors.full_messages }
		end
	end

  def shift_params
  	shift_timings = params[:hotels][:shift_timings]
  	shift_timings.map { |obj| {start_time: obj[:start_time], end_time: obj[:end_time]} }
  end
  
	def hotel_params
		params.require(:hotels).permit(:name, :email, :phone)
	end
end

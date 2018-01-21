class WorkingShiftsController < ApplicationController
  before_action :set_hotel
 
 def create_working_shift
   working_shifts = @hotel.working_shifts.create(shift_params)
   error_messages =  working_shifts.collect { |shift| {message: shift.errors.full_messages, object: shift} if shift.errors.messages.present? }.reject(&:nil?)
   shift_obj =  working_shifts.collect { |shift| shift if shift.errors.messages.blank? }.reject(&:nil?)
   error_message = error_message.present? ? error_messages : []
   render json: { success: shift_obj, errors: error_messages } 
 end

private
  def shift_params
  	shift_timings = params[:shift_timings]
  	shift_timings.map { |obj| {start_time: obj[:start_time], end_time: obj[:end_time] } }
  end

 def set_hotel
  @hotel = Hotel.find(params[:id])
 rescue ActiveRecord::RecordNotFound
    render json: { status: 400, messsage: ' Hotel Not Found'} 
 end
end

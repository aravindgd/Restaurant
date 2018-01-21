class GuestsController < ApplicationController
  
  def create
  	@guest = Guest.new(guest_params)
  	if @guest.save
  	  render json: { status: 200, data: @guest }
  	else
  	  render json: { created: false, errors: @guest.errors.full_messages.join(',') }
  	end
  end

  def guest_params
  	params.require(:guests).permit(:name, :email)
  end
end

class ReservationsController < ApplicationController
  def new
   @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.device = Device.find(params[:id])
    @reservation.user = current_user
    if @reservation.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :total_price)
  end
end

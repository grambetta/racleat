class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    authorize @reservation
    @device = Device.find(params[:device_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    authorize @reservation
    @device = Device.find(params[:device_id])
    @reservation.device = @device
    @reservation.user = current_user
    @reservation.total_price = @device.price * (@reservation.end_date - @reservation.start_date).to_i
    if @reservation.save
      redirect_to dashboard_path
    else
      render 'devices/show'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  def update
    @reservation = Reservation.find(params[:id])
    authorize @reservation
    @reservation.update(reservation_params)
    redirect_to reservation_path(@reservation)
  end

  def destroy
    @reservation = reservation.find(params[:id])
    authorize @reservation
    @reservation.destroy
    redirect_to dashboard_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :total_price)
  end
end

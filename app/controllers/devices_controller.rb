class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = current_user.devices.new
    authorize @device
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    authorize @device
    if @device.save
      redirect_to device_path(@device)
    else
      render :new
    end
  end

  def edit
    authorize @device
    @device = Device.find(params[:id])
  end

  def update
    authorize @device
    @device = Device.find(params[:id])
    @device.update(device_params)
    redirect_to device_path(@device)
  end

  def destroy
    @device = device.find(params[:id])
    @device.destroy
    redirect_to devices_path
  end

  private

  def device_params
    params.require(:device).permit(:user_id, :name, :device_type, :capacity, :brand, :address, :price)
  end
end

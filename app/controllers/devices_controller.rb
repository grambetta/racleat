class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to_device_path
    else
      render :new
    end
  end

  private

  def device_params
    params.require(:device).permit(:name, :device_type, :capacity, :brand, :address, :price, photos: [])
  end
end

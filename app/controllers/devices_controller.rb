class DevicesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @devices = policy_scope(Device)
  end

  def show
    @device = Device.find(params[:id])
    authorize @device

  end

  def new
    @device = current_user.devices.new
    authorize @device
  end

  def create
    @device = current_user.devices.new(device_params)
    authorize @device
    if @device.save
      redirect_to device_path(@device)
    else
      render :new
    end
  end

  def edit
    @device = Device.find(params[:id])
    authorize @device
  end

  def update
    @device = Device.find(params[:id])
    authorize @device
    @device.update(device_params)
    redirect_to device_path(@device)
  end

  def destroy
    @device = device.find(params[:id])
    authorize @device
    @device.destroy
    redirect_to devices_path
  end

  private

  def device_params
    params.require(:device).permit(:user_id, :name, :device_type, :capacity, :brand, :address, :price)
  end
end

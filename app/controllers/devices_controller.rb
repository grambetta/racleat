class DevicesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      # int_query = (params[:query].gsub(/[^0-9]/, '')).to_i
      # sql_query = "name @@ :query OR brand @@ :query OR capacity = :int_query OR device_type @@ :query"
      # @devices = policy_scope(Device).where(sql_query, query: params[:query], int_query: int_query)
      @devices = policy_scope(Device).search_by_all_fields(params[:query])
    else
      @devices = policy_scope(Device)
    end
    @markers = @devices.geocoded.map do |device|
      {
        lat: device.latitude,
        lng: device.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { device: device })
      }
    end
  end

  def show
    @device = Device.find(params[:id])
    @reservation = Reservation.new
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
    params.require(:device).permit(:user_id, :name, :device_type, :capacity, :brand, :address, :price, photos: [])
  end
end

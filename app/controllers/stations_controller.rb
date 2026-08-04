class StationsController < ApplicationController
  before_action :set_station, only: %i[show edit update destroy]

  def index
    @stations = current_account.stations.order(:name)
  end

  def show
    @islands = @station.islands.includes(:service_points)
  end

  def new
    @station = current_account.stations.new
  end

  def create
    @station = current_account.stations.new(station_params)
    if @station.save
      redirect_to @station, notice: "Estación creada correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @station.update(station_params)
      redirect_to @station, notice: "Estación actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @station.destroy
    redirect_to stations_path, notice: "Estación eliminada."
  end

  private

  def set_station
    @station = current_account.stations.find(params[:id])
  end

  def station_params
    params.require(:station).permit(:name, :province, :canton, :address, :status)
  end
end

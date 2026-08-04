class ServicePointsController < ApplicationController
  before_action :set_island, only: %i[new create]
  before_action :set_service_point, only: %i[edit update destroy]

  def new
    @service_point = @island.service_points.new
  end

  def create
    @service_point = @island.service_points.new(service_point_params)
    if @service_point.save
      redirect_to station_path(@island.station), notice: "Surtidor agregado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @service_point.update(service_point_params)
      redirect_to station_path(@service_point.island.station), notice: "Surtidor actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    station = @service_point.island.station
    @service_point.destroy
    redirect_to station_path(station), notice: "Surtidor eliminado."
  end

  private

  def set_island
    @island = Island.joins(:station).where(stations: { account_id: current_account.id }).find(params[:island_id])
  end

  def set_service_point
    @service_point = ServicePoint.joins(island: :station)
                                  .where(stations: { account_id: current_account.id })
                                  .find(params[:id])
  end

  def service_point_params
    params.require(:service_point).permit(:label, :kind, :status)
  end
end

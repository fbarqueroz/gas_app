class IslandsController < ApplicationController
  before_action :set_station, only: %i[new create]
  before_action :set_island, only: %i[edit update destroy]

  def new
    @island = @station.islands.new
  end

  def create
    @island = @station.islands.new(island_params)
    if @island.save
      redirect_to station_path(@station), notice: "Isla creada."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @island.update(island_params)
      redirect_to station_path(@island.station), notice: "Isla actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    station = @island.station
    @island.destroy
    redirect_to station_path(station), notice: "Isla eliminada."
  end

  private

  def set_station
    @station = current_account.stations.find(params[:station_id])
  end

  def set_island
    @island = Island.joins(:station).where(stations: { account_id: current_account.id }).find(params[:id])
  end

  def island_params
    params.require(:island).permit(:name)
  end
end

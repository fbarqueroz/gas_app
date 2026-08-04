class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show close]

  def index
    @shifts = Shift.joins(:station)
                    .where(stations: { account_id: current_account.id })
                    .order(opened_at: :desc)
                    .limit(50)
  end

  def show
    @sales = @shift.sales.includes(:product)
  end

  def new
    @shift = Shift.new(station_id: params[:station_id])
    @stations = current_account.stations
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.attendant = current_user
    @shift.opened_at = Time.current

    if @shift.save
      redirect_to @shift, notice: "Turno abierto."
    else
      @stations = current_account.stations
      render :new, status: :unprocessable_entity
    end
  end

  def close
    # El pistero cuenta el efectivo en colones; lo guardamos internamente
    # en céntimos, igual que el resto de montos del sistema.
    counted_colones = params[:counted_cash_cents_colones].to_i
    @shift.close!(counted_cash_cents: counted_colones * 100)
    redirect_to @shift, notice: "Turno cerrado y caja arqueada."
  end

  private

  def set_shift
    @shift = Shift.joins(:station).where(stations: { account_id: current_account.id }).find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:station_id)
  end
end

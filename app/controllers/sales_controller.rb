class SalesController < ApplicationController
  before_action :set_shift

  def create
    @sale = @shift.sales.new(sale_params.except(:unit_price_colones))
    @sale.station = @shift.station
    @sale.unit_price_cents = sale_params[:unit_price_colones].to_i * 100

    if @sale.save
      redirect_to @shift, notice: "Venta registrada."
    else
      redirect_to @shift, alert: @sale.errors.full_messages.to_sentence
    end
  end

  private

  def set_shift
    @shift = Shift.joins(:station).where(stations: { account_id: current_account.id }).find(params[:shift_id])
  end

  def sale_params
    params.require(:sale).permit(:product_id, :service_point_id, :quantity, :unit_price_colones, :payment_method)
  end
end

class DashboardController < ApplicationController
  def index
    @stations = current_account.stations
    @open_shifts = Shift.joins(:station).where(stations: { account_id: current_account.id }, status: :open)
    @today_sales = Sale.joins(:station)
                        .where(stations: { account_id: current_account.id })
                        .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @today_total_cents = @today_sales.sum(:total_cents)
    @cash_differences_cents = CashRegister.joins(shift: :station)
                                           .where(stations: { account_id: current_account.id })
                                           .where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
                                           .sum(:difference_cents)
  end
end

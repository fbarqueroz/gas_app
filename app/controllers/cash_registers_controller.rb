class CashRegistersController < ApplicationController
  def index
    @cash_registers = CashRegister.joins(shift: :station)
                                   .where(stations: { account_id: current_account.id })
                                   .order(created_at: :desc)
                                   .limit(50)
  end

  def show
    @cash_register = CashRegister.joins(shift: :station)
                                  .where(stations: { account_id: current_account.id })
                                  .find(params[:id])
  end
end

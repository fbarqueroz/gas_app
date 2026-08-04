# Corte de caja de un turno: efectivo esperado (según ventas en efectivo)
# vs. efectivo contado por el pistero/cajero, con la diferencia calculada.
class CashRegister < ApplicationRecord
  belongs_to :shift

  validates :expected_cash_cents, :counted_cash_cents, :difference_cents,
            numericality: true

  def balanced?
    difference_cents.zero?
  end
end

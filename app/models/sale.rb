# Registro de una venta (despacho de combustible u otro producto) durante
# un turno. total_cents = quantity * unit_price_cents, calculado antes de
# guardar para no depender del precio actual del producto más adelante.
class Sale < ApplicationRecord
  belongs_to :shift
  belongs_to :station
  belongs_to :product
  belongs_to :service_point, optional: true
  has_one :payment, dependent: :destroy

  enum :payment_method, {
    cash: "cash",
    card: "card",
    sinpe_movil: "sinpe_movil",
    credit_account: "credit_account"
  }

  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price_cents, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_total

  private

  def calculate_total
    self.total_cents = (quantity.to_f * unit_price_cents.to_i).round
  end
end

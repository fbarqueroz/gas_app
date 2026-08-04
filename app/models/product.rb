# Súper, Regular, Diésel, recarga kWh, lavado, comida, etc. Vive a nivel
# de Account porque el precio puede variar por estación (price_cents en
# StationProduct sería el siguiente paso; por ahora se maneja un precio
# base por producto para simplificar el MVP).
class Product < ApplicationRecord
  belongs_to :account

  has_many :sales, dependent: :restrict_with_error

  enum :category, {
    fuel: "fuel",
    ev_charge: "ev_charge",
    store: "store",
    car_wash: "car_wash",
    food: "food",
    other: "other"
  }, default: "fuel"

  validates :name, presence: true
  validates :unit, presence: true # litro, kWh, unidad
  validates :base_price_cents, numericality: { greater_than_or_equal_to: 0 }

  # base_price_cents se guarda en céntimos de colón para evitar errores de
  # punto flotante; se puede sumar el gem "money-rails" más adelante si se
  # necesita manejar varias monedas.
end

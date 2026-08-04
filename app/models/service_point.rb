# Generaliza una bomba de combustible o, a futuro, un cargador eléctrico,
# para no tener que rediseñar el modelo cuando llegue la electromovilidad.
class ServicePoint < ApplicationRecord
  belongs_to :island
  has_one :station, through: :island

  has_many :sales, dependent: :nullify

  enum :kind, { fuel_pump: "fuel_pump", ev_charger: "ev_charger" }, default: "fuel_pump"
  enum :status, { operational: "operational", maintenance: "maintenance", out_of_service: "out_of_service" },
       default: "operational"

  validates :label, presence: true
end

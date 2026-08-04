# Agrupación de bombas/surtidores dentro de una estación (ej. "Isla 1").
class Island < ApplicationRecord
  belongs_to :station

  has_many :service_points, dependent: :destroy

  validates :name, presence: true
end

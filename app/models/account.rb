# Empresa/Tenant. Ej: "Grupo Gekko", o un grupo empresarial dueño de varias
# estaciones. Todo el resto del modelo de datos cuelga de un account_id
# (multi-tenant por columna, según el roadmap técnico).
class Account < ApplicationRecord
  has_many :stations, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :legal_id, uniqueness: true, allow_blank: true

  before_validation :generate_slug, on: :create

  has_secure_token :api_token

  private

  def generate_slug
    return if name.blank?
    self.slug ||= name.to_s.parameterize
  end
end

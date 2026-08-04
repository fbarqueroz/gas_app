# Una estación de servicio física.
class Station < ApplicationRecord
  belongs_to :account

  has_many :islands, dependent: :destroy
  has_many :service_points, through: :islands
  has_many :shifts, dependent: :destroy
  has_many :sales, through: :shifts
  has_many :cash_registers, through: :shifts

  validates :name, presence: true
  validates :province, presence: true

  enum :status, { active: "active", paused: "paused", closed: "closed" }, default: "active"

  scope :for_account, ->(account) { where(account: account) }
end

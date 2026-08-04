class User < ApplicationRecord
  belongs_to :account, optional: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :trackable

  has_many :shifts, foreign_key: :attendant_id, inverse_of: :attendant, dependent: :nullify

  enum :role, {
    owner: "owner",
    manager: "manager",
    cashier: "cashier",
    attendant: "attendant",
    auditor: "auditor"
  }, default: "attendant"

  validates :full_name, presence: true

  def admin_area?
    owner? || manager? || auditor?
  end
end

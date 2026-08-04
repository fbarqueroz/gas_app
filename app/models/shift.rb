# Turno de un pistero/cajero en una estación: apertura, ventas asociadas y
# cierre con arqueo de caja.
class Shift < ApplicationRecord
  belongs_to :station
  belongs_to :attendant, class_name: "User", inverse_of: :shifts

  has_many :sales, dependent: :destroy
  has_one :cash_register, dependent: :destroy

  enum :status, { open: "open", closed: "closed" }, default: "open"

  validates :opened_at, presence: true

  def total_sales_cents
    sales.sum(:total_cents)
  end

  def close!(counted_cash_cents:)
    transaction do
      update!(status: :closed, closed_at: Time.current)
      expected_cash_cents = sales.where(payment_method: :cash).sum(:total_cents)
      create_cash_register!(
        expected_cash_cents: expected_cash_cents,
        counted_cash_cents: counted_cash_cents,
        difference_cents: counted_cash_cents - expected_cash_cents
      )
    end
  end
end

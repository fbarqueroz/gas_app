# Detalle del pago asociado a una venta: referencia Sinpe Móvil, token de
# tarjeta (nunca el PAN completo — cumplimiento PCI DSS), o efectivo.
class Payment < ApplicationRecord
  belongs_to :sale

  enum :status, { pending: "pending", confirmed: "confirmed", rejected: "rejected" }, default: "pending"

  # sinpe_reference: comprobante/referencia que el pistero anota al validar
  # manualmente la transferencia (MVP1). En MVP posterior se reemplaza por
  # conciliación automática vía API/CSV bancario.
end

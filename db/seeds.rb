puts "== Sembrando datos demo de Grupo Gekko =="

account = Account.find_or_create_by!(name: "Grupo Gekko") do |a|
  a.legal_id = "3-101-000000"
end

admin = User.find_or_initialize_by(email: "admin@grupogekko.cr")
admin.assign_attributes(
  full_name: "Administrador Gekko",
  password: "gekko1234",
  password_confirmation: "gekko1234",
  role: :owner,
  account: account
)
admin.save!

station = Station.find_or_create_by!(account: account, name: "Estación San José Centro") do |s|
  s.province = "San José"
  s.canton = "San José"
  s.address = "200m oeste del Parque Central"
end

island = Island.find_or_create_by!(station: station, name: "Isla 1")

%w[SP-1 SP-2 SP-3 SP-4].each do |label|
  ServicePoint.find_or_create_by!(island: island, label: label)
end

products = [
  { name: "Súper", category: :fuel, unit: "litro", base_price_cents: 70500 },
  { name: "Regular", category: :fuel, unit: "litro", base_price_cents: 68300 },
  { name: "Diésel", category: :fuel, unit: "litro", base_price_cents: 59400 },
  { name: "Lavado básico", category: :car_wash, unit: "unidad", base_price_cents: 350000 }
]

products.each do |attrs|
  Product.find_or_create_by!(account: account, name: attrs[:name]) do |p|
    p.category = attrs[:category]
    p.unit = attrs[:unit]
    p.base_price_cents = attrs[:base_price_cents]
  end
end

pistero = User.find_or_initialize_by(email: "pistero@grupogekko.cr")
pistero.assign_attributes(
  full_name: "Pistero Demo",
  password: "gekko1234",
  password_confirmation: "gekko1234",
  role: :attendant,
  account: account
)
pistero.save!

puts "== Listo =="
puts "Ingresá con admin@grupogekko.cr / gekko1234"

# Grupo Gekko — Plataforma SaaS para Gasolineras (MVP 1)

Base técnica del MVP 1 ("Administración de estaciones") descrito en el roadmap:
control multi-tenant de estaciones, turnos, ventas manuales y caja, sobre
**Ruby on Rails 7 + Hotwire/Turbo + Tailwind (estilo Material Design)**,
levantado con **Docker Compose** y **PostgreSQL en contenedor** (gratis
mientras se desarrolla; luego se puede apuntar a Supabase/Neon en producción
sin cambiar código, solo `DATABASE_URL`).

Marca aplicada: **Grupo Gekko** — verde `#2BAE66`, negro `#000000`, blanco
`#FFFFFF`, tipografías Poppins (principal) y Montserrat (secundaria).

## Qué incluye este MVP

- Multi-tenant: `Account` (empresa) → `Station` (estación) → `Island` (isla)
  → `ServicePoint` (bomba/surtidor, generalizado para soportar EV a futuro).
- `Product` (súper, regular, diésel, kWh, etc.) por cuenta.
- `User` con autenticación (Devise) y roles: `owner`, `manager`, `cashier`,
  `attendant` (pistero), `auditor`.
- `Shift` (turno de pistero): apertura/cierre, arqueo.
- `Sale` (venta manual por surtidor/producto/método de pago).
- `Payment` (efectivo, tarjeta, Sinpe Móvil — con campo de referencia).
- `CashRegister` (corte de caja por turno, diferencia calculada).
- Panel web (Turbo/ERB, sin necesidad de un frontend separado) con:
  - Login con la identidad de marca.
  - Dashboard con tarjetas KPI (ventas del día, diferencias de caja, turnos
    abiertos) — estilo Material (elevación, esquinas redondeadas, color de
    acento verde).
  - CRUD de estaciones e islas/surtidores.
  - Registro y cierre de turnos con ventas y arqueo de caja.

Todo pensado para conectarse después con: app Android de pisteros (consume
la misma API JSON que ya exponen estos controladores), conciliación Sinpe
Móvil, facturación electrónica y el resto de fases del roadmap.

## Requisitos para correrlo

- Docker y Docker Compose instalados (Docker Desktop en Mac/Windows, o
  docker + docker-compose-plugin en Linux).
- Nada más — Ruby, Postgres, Redis, todo vive dentro de los contenedores.

## Cómo levantarlo

```bash
# 1. Copiar variables de entorno de ejemplo
cp .env.example .env

# 2. Construir las imágenes (la primera vez descarga gemas, tarda unos minutos)
docker compose build

# 3. Preparar la base de datos (crea + migra + siembra datos demo)
docker compose run --rm app bin/rails db:prepare
docker compose run --rm app bin/rails db:seed

# 4. Levantar todo
docker compose up
```

La app queda disponible en **http://localhost:3000**.

> **Tip de desarrollo:** el CSS de Tailwind se compila una vez al arrancar
> el contenedor. Si vas a estar tocando estilos seguido, abrí una segunda
> terminal y dejá corriendo el watcher en vivo:
> `docker compose exec app bin/rails tailwindcss:watch`

Usuario demo (creado por `db:seed`):

- Correo: `admin@grupogekko.cr`
- Contraseña: `gekko1234`

## Estructura de servicios (docker-compose.yml)

| Servicio | Rol | Notas |
|---|---|---|
| `app` | Rails 7 (Puma) + assets Tailwind | Puerto 3000 |
| `db` | PostgreSQL 16 | Volumen persistente `db_data`, gratis en local |
| `redis` | Redis 7 | Cache, Turbo Streams, y base para Sidekiq cuando se agregue |

Cuando se pase a producción, `db` se puede reemplazar por una base
administrada gratuita tipo **Supabase** o **Neon** (ambas con plan free de
Postgres) solo cambiando `DATABASE_URL` en el `.env` — el código de Rails no
cambia.

## Próximos pasos sugeridos (según el roadmap)

1. Reportes exportables (PDF/Excel) y logs de auditoría (Mes 4).
2. App Android de pisteros consumiendo la API JSON ya expuesta (Mes 5).
3. Piloto en 1–2 estaciones (Mes 6).
4. Conciliación automática de Sinpe Móvil (Mes 7).
5. Sidekiq para jobs en background (reportes, notificaciones) — el servicio
   `redis` ya está listo para esto, solo falta agregar el gem `sidekiq` y el
   contenedor `worker` en `docker-compose.yml`.

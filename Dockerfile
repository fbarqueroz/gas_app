# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3.0
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /app

# Dependencias del sistema necesarias para Rails + Postgres + Tailwind CLI
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libyaml-dev \
    git \
    curl \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH="/usr/local/bundle" \
    RAILS_ENV="development" \
    RAILS_LOG_TO_STDOUT="true"

# Instalar gemas (capa cacheable)
COPY Gemfile Gemfile.lock* ./
RUN bundle config set --local without 'production' && \
    bundle install --jobs 4 --retry 3

# Copiar el resto de la app
COPY . .

# Precompilar binstubs ejecutables
RUN chmod +x bin/* || true

EXPOSE 3000

ENTRYPOINT ["bin/docker-entrypoint"]

CMD ["bin/rails", "server", "-b", "0.0.0.0"]

#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -o errexit

# Install dependencies
bundle install

# Precompile and clean assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Run migrations safely (avoid duplicate execution issues)
if bundle exec rails db:migrate:status | grep "down"; then
  echo "⚡ Running migrations..."
  bundle exec rails db:migrate
else
  echo "✅ No pending migrations."
fi

# Seed the database (optional, remove if not needed in every deployment)
if [[ "$RESEED_DB" == "true" ]]; then
  echo "⚡ Seeding database..."
  bundle exec rails db:seed
fi

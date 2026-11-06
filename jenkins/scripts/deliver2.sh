#!/usr/bin/env sh

set -eu

export NODE_OPTIONS=--openssl-legacy-provider
export PORT=3001

npm ci
npm run build

npm start &
APP_PID=$!
echo "$APP_PID" > .pidfile

sleep 2

if ! kill -0 "$APP_PID" 2>/dev/null; then
    echo "ERROR: Application failed to start."
    exit 1
fi

echo "Application started with PID: $APP_PID"
echo "Visit http://localhost:3001"

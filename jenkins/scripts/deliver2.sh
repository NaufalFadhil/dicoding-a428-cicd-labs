
#!/usr/bin/env sh

set -eu

# Compatibility for legacy Webpack 4 on Node.js 22
export NODE_OPTIONS=--openssl-legacy-provider

echo "Installing dependencies..."
npm ci

echo "Building React application..."
npm run build

echo "Starting React application..."
npm start &

APP_PID=$!
echo "$APP_PID" > .pidfile

sleep 2

if ! kill -0 "$APP_PID" 2>/dev/null; then
    echo "ERROR: Application failed to start."
    exit 1
fi

echo "Application started with PID: $APP_PID"
echo "Visit http://localhost:3000"

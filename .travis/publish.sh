#!/usr/bin/env bash
mkdir -p ~/.pub-cache

cat <<EOF > ~/.pub-cache/credentials.json
{
  "accessToken":"$accessToken",
  "refreshToken":"$refreshToken",
  "tokenEndpoint":"$tokenEndpoint",
  "scopes": [$scopes_array],
  "expiration":$expiration
}
EOF

pub publish -f
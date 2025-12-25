#!/bin/bash
set -e

COMPOSE_FILE="$1"

echo "services<<EOF" >> "$GITHUB_OUTPUT"
docker compose -f "$COMPOSE_FILE" config --services >> "$GITHUB_OUTPUT"
echo "EOF" >> "$GITHUB_OUTPUT"
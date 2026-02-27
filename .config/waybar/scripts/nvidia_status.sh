#!/usr/bin/env bash

# Check the line “Suspended” vs “Active” in supergfxctl output
state=$(supergfxctl -S)

if grep -q "suspended" <<<"$state"; then
  printf '{"icon":" ","text":"","class":"suspended"}'
else
  printf '{"icon":" ","text":"","class":"active"}'
fi

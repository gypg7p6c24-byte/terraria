#!/bin/bash
set -e

cd /home/steam/terraria

echo "Starting Terraria Server..."

exec ./TerrariaServer.bin.x86_64 -port 7777 -config serverconfig.txt

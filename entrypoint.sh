#!/bin/bash
set -e

cd /home/steam/terraria

echo "Starting Terraria Server..."

exec ./TerrariaServer.bin.x86_64 \
  -port 7777 \
  -world /home/steam/terraria/Worlds/world.wld \
  -autocreate 2 \
  -worldname world \
  -difficulty 0

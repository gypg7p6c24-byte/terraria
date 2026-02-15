#!/bin/bash
set -e

echo "Starting Terraria Server..."

cd /home/steam/terraria

mono TerrariaServer.exe \
  -port 7777 \
  -world /home/steam/terraria/Worlds/world.wld \
  -autocreate 2 \
  -worldname world \
  -difficulty 0

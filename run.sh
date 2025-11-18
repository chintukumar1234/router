#!/bin/bash
set -e

MAP_URL="https://drive.google.com/uc?export=download&id=1Tr-eJ9iwPodGC_Hx-z0LVa3gBDNf7cj5"

echo "📥 Downloading map..."
curl -L -o eastern-zone-251111.osm.pbf "$MAP_URL"

echo "🔧 Running osrm-extract..."
osrm-extract -p /opt/car.lua eastern-zone-251111.osm.pbf

echo "📌 Running osrm-partition..."
osrm-partition eastern-zone-251111.osrm

echo "🧠 Running osrm-customize..."
osrm-customize eastern-zone-251111.osrm

echo "🚀 Starting OSRM server..."
osrm-routed --algorithm mld eastern-zone-251111.osrm

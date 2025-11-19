#!/bin/bash
set -e

MAP_URL="https://drive.google.com/uc?export=download&id=1Tr-eJ9iwPodGC_Hx-z0LVa3gBDNf7cj5"
OUTPUT_FILE="eastern-zone-251111.osm.pbf"

echo "📥 Downloading map..."
# Use curl instead of wget
curl -L -o "$OUTPUT_FILE" "$MAP_URL"

echo "🔧 Running osrm-extract..."
osrm-extract -p /opt/car.lua "$OUTPUT_FILE"

echo "📌 Running osrm-partition..."
osrm-partition "${OUTPUT_FILE%.osm.pbf}.osrm"

echo "🧠 Running osrm-customize..."
osrm-customize "${OUTPUT_FILE%.osm.pbf}.osrm"

echo "🚀 Starting OSRM server..."
osrm-routed --algorithm mld "${OUTPUT_FILE%.osm.pbf}.osrm"

#!/bin/bash
set -e

FILE_ID="1Tr-eJ9iwPodGC_Hx-z0LVa3gBDNf7cj5"
OUTPUT_FILE="eastern-zone-251111.osm.pbf"

echo "📥 Downloading map from Google Drive with curl..."

# First request to get confirmation token for large files
CONFIRM=$(curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=${FILE_ID}" \
    | grep -o 'confirm=[0-9A-Za-z_]*' | head -n 1 | cut -d= -f2)

# Download the file with the confirmation token
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o "$OUTPUT_FILE"

echo "🔧 Running osrm-extract..."
osrm-extract -p /opt/car.lua "$OUTPUT_FILE"

echo "📌 Running osrm-partition..."
osrm-partition "${OUTPUT_FILE%.osm.pbf}.osrm"

echo "🧠 Running osrm-customize..."
osrm-customize "${OUTPUT_FILE%.osm.pbf}.osrm"

echo "🚀 Starting OSRM server..."
osrm-routed --algorithm mld "${OUTPUT_FILE%.osm.pbf}.osrm"

#!/bin/bash

# Path to your local PBF
OUTPUT_FILE=/data/eastern-zone-251111.osm.pbf

# Check if file exists
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "Error: $OUTPUT_FILE not found."
    exit 1
fi

# Run OSRM
osrm-extract -p /opt/car.lua "$OUTPUT_FILE"
osrm-partition "$OUTPUT_FILE"
osrm-customize "$OUTPUT_FILE"
osrm-routed --algorithm mld "$OUTPUT_FILE"

# Use official OSRM backend image
FROM osrm/osrm-backend:latest

# Copy preprocessed OSRM files into /data
COPY ./data /data

# Expose the default OSRM port
EXPOSE 5000

# Run OSRM server directly without a separate script
CMD ["osrm-routed", "--algorithm", "mld", "/data/eastern-zone-251111.osrm"]

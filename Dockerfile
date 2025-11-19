# Use a newer OSRM image based on Debian Bullseye
FROM osrm/osrm-backend:v5.34.0-bullseye

WORKDIR /data

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy your run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Expose OSRM port
EXPOSE 5000

# Run your script
CMD ["/run.sh"]

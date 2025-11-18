# Use the official OSRM backend image
FROM osrm/osrm-backend:latest

# Install curl (Debian-based image)
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set working directory for OSRM commands
WORKDIR /data

# Copy the run script and make it executable
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Expose the default OSRM port
EXPOSE 5000

# Run your script
CMD ["/run.sh"]

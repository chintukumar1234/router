FROM osrm/osrm-backend

# Install curl
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# OSRM commands will run in /data
WORKDIR /data

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]

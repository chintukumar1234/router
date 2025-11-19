FROM osrm/osrm-backend:latest

WORKDIR /data

# Fix Debian Stretch repos and install curl
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i '/stretch-updates/d' /etc/apt/sources.list \
    && sed -i '/security.debian.org/d' /etc/apt/sources.list \
    && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until \
    && apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the fixed run.sh
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]

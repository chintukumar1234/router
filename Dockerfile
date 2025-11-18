FROM osrm/osrm-backend

# OSRM commands will run in /data
WORKDIR /data

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]

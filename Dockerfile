FROM osrm/osrm-backend:latest

WORKDIR /data

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]

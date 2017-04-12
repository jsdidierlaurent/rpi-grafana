# rpi-grafana
Docker Container for Raspberry Pi with Grafana 4.2.0

# Using this Image
## Grafana container with persistent storage
```
# create /var/lib/grafana as persistent volume storage
docker run -d -v /var/lib/grafana --name grafana-storage busybox:latest

# start grafana
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  --volumes-from grafana-storage \
  jsdidierlaurent/rpi-grafana
```

## Grafana in docker swarm with docker-compose
```
version: '3'

services:
  grafana:
    image: jsdidierlaurent/rpi-grafana
    ports:
      - 3000:3000
    volumes:
      - grafana-db:/var/lib/grafana
      - grafana-log:/var/log/grafana
      - grafana-conf:/etc/grafana
    deploy:
      replicas: 1
      placement:
        constraints:
          - node.role == manager

volumes:
  grafana-db:
    driver: local  
  grafana-log:
    driver: local
  grafana-conf:
    driver: local
```
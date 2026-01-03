@echo off

docker network create --subnet 172.18.0.0/24 elastic
docker pull docker.elastic.co/kibana/kibana:9.2.3
docker run --name kib01 --net elastic --ip 172.18.0.3 -p 5601:5601 -m 4GB docker.elastic.co/kibana/kibana:9.2.3

pause

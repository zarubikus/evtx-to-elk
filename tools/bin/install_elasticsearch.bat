@echo off

docker network create --subnet 172.18.0.0/24 elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:9.2.3
docker run --name es01 --net elastic --ip 172.18.0.2 -p 9200:9200 -it -m 6GB -e "discovery.type=single-node" -e "xpack.security.enabled=false" -e "xpack.security.http.ssl.enabled=false" -e "xpack.ml.use_auto_machine_memory_percent=true" docker.elastic.co/elasticsearch/elasticsearch:9.2.3

pause

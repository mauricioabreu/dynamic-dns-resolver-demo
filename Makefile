create_network:
	@docker network create --subnet=172.20.0.0/16 ddnsr

start_edge:
	@docker build -t ddnsr-demo/edge -f edge/Dockerfile .
	@docker run -d --rm --net ddnsr -p 8080:8080 -v $(shell pwd)/edge/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v $(shell pwd)/edge/src/:/lua/src/ -v $(shell pwd)/edge/resolv.conf/:/etc/resolv.conf ddnsr-demo/edge

start_dns:
	@docker build -t ddnsr-demo/coredns -f dns/Dockerfile .
	@docker run -d --rm --net ddnsr --ip 172.20.0.2 --expose=53 --expose=53/udp -p 53:53 -p 53:53/udp -v $(shell pwd)/dns/config:/etc/coredns ddnsr-demo/coredns -conf /etc/coredns/Corefile

start_upstreams:
	@docker build -t ddnsr-demo/upstream -f upstream/Dockerfile .
	@docker run -d --rm --net ddnsr --ip 172.20.0.3 -v $(shell pwd)/upstream/hello.conf:/etc/nginx/nginx.conf -p 8082:80 ddnsr-demo/upstream
	@docker run -d --rm --net ddnsr --ip 172.20.0.4 -v $(shell pwd)/upstream/hello.conf:/etc/nginx/nginx.conf -p 8083:80 ddnsr-demo/upstream

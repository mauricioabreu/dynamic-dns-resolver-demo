start_edge:
	@docker build -t ddnsr-demo/edge -f edge/Dockerfile .
	@docker run -d --rm --net ddnsr -p 8080:8080 -v $(shell pwd)/edge/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -v $(shell pwd)/edge/src/:/lua/src/ ddnsr-demo/edge

start_dns:
	@docker build -t ddnsr-demo/coredns -f dns/Dockerfile .
	@docker run -d --rm --net ddnsr --ip 172.20.0.2 --expose=53 --expose=53/udp -p 53:53 -p 53:53/udp -v $(shell pwd)/dns/config:/etc/coredns ddnsr-demo/coredns -conf /etc/coredns/Corefile

start_upstreams:
	@docker run -d --rm --net ddnsr --ip 172.20.0.3 -p 8082:80 nginxdemos/hello
	@docker run -d --rm --net ddnsr --ip 172.20.0.4 -p 8083:80 nginxdemos/hello
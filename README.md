# Dynamic DNS resolver demo

> A repository to emulate dynamic DNS resolving using a lua library

The reasoning behind this repository is to understand how this resolver works
at the same time we have a real project to demonstrate it working.

## Usage

> These containers run in a custom network. Run `docker network create --subnet=172.20.0.0/16 ddnsr` to create it

First, fire up two upstreams. These will be our NGINX upstreams used to emulate invalid IPs being cached by NGINX.

```console
make start_upstreams
```

Now we can start our DNS server to answer queries from our NGINX edge:

```console
make start_dns
```

And finally, we need to get our edge up and running to use the DNS server to simulate the dynamic DNS resolver working:

```console
make start_edge
```

Now you can change the `dns/config/ddnsr-demo.hosts` file and check if `localhost:8080?backend=hello` still works.

There are two IPs you can use to simulate this: `172.20.0.3` and `172.20.0.4`

## Testing keep-alive connections

To check if the keepalive feature still works after using dynamic DNS resolver, use `tcpdump`:

1) open up a terminal in the `edge` container
2) execute `tcpdump -i any -nn -s0 -vvv "dst 172.20.0.3 and tcp[tcpflags] & tcp-syn != 0"`
3) make a request to `localhost:8080` check if received a line containing `Flags [S]`
4) repeat the request above and check if you are still receiving that line

If you did not receive it twice, keep-alive is working fine.

## Upstream as a variable

There are some known behaviors when using upstreams as variables:

Use `localhost:8080?backend=hello` for fetching data from the `hello` app that has IPs dynamically resolved.

or

`localhost:8080?backend=local` for fetching data from a dummy backend.

Requests made for the `hello` app have a header `X-Upstream` to better understand where the data is coming from.

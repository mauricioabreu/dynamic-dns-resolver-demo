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

Now you can change the `dns/config/ddnsr-demo.hosts` file and check if `localhost:8080` still works.

There are two IPs you can use to simulate this: `172.20.0.3` and `172.20.0.4`
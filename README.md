# Dynamic DNS resolver demo

> A repository to emulate dynamic DNS resolving using a lua library

The reasoning behind this repository is to understand how this resolver works
at the same time we have a real project to demonstrate it working.

## Usage

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
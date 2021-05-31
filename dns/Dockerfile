FROM coredns/coredns:latest

EXPOSE 53 53/udp

VOLUME ["/etc/coredns"]

ENTRYPOINT ["/coredns"]

CMD ["-conf", "/etc/coredns/Corefile"]
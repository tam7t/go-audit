FROM ubuntu:xenial

RUN apt update && apt install -y auditd && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD go-audit /bin/go-audit

ENTRYPOINT ["/bin/go-audit", "--config", "/etc/go-audit.yaml"]

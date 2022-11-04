FROM busybox:uclibc
COPY prometheus-webhook-dingtalk /bin/
COPY contrib/k8s/config/config.yaml /etc/prometheus-webhook-dingtalk/
WORKDIR /etc/prometheus-webhook-dingtalk/
CMD        [ "/bin/prometheus-webhook-dingtalk", "--config.file=/etc/prometheus-webhook-dingtalk/config.yml" ]


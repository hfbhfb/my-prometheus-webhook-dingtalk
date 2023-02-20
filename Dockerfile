FROM busybox:uclibc
COPY prometheus-webhook-dingtalk /bin/

COPY config.example.yml                 /etc/prometheus-webhook-dingtalk/config.yml
COPY contrib                            /etc/prometheus-webhook-dingtalk/
COPY template/default.tmpl              /etc/prometheus-webhook-dingtalk/template/default.tmpl
#

WORKDIR /etc/prometheus-webhook-dingtalk/
#CMD [ "/bin/prometheus-webhook-dingtalk", "--config.file=/etc/prometheus-webhook-dingtalk/config.yml" ]
#CMD [ "sh", "-c" , "printenv;pwd;sleep 88777" ]
CMD [ "sh", "-c" , "/bin/prometheus-webhook-dingtalk --config.file=/etc/prometheus-webhook-dingtalk/config.yml" ]


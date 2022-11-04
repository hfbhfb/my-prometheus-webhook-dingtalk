
## 为什么要改动?? 因为有如下报错
``` bash
level=error ts=2022-11-03T08:26:05.891Z caller=dingtalk.go:97 component=web target=webhook2 msg="Failed to send notification" err="error sending notification to DingTalk: Post \"https://oapi.dingtalk.com/robot/send?access_token=a611ce2e561db721": x509: certificate is valid for *.mytrafficmanagement.com, mytrafficmanagement.com, not oapi.dingtalk.com"

# curl命令又是正常
$ curl 'https://oapi.dingtalk.com/robot/send?access_token=a611ce2e561db7d8' -H 'Content-Type: application/json' -d'{"msgtype": "text","text": {"content":"123名称:alertname这里替换成你要发送的消息,关键词是名称2关键词lert"},"alertname":"111"}' -v -k
*   Trying 106.11.23.24...
* TCP_NODELAY set
* Connected to oapi.dingtalk.com (106.11.23.24) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use h2
* Server certificate:
*  subject: C=CN; ST=ZheJiang; L=HangZhou; O=Alibaba (China) Technology Co., Ltd.; CN=*.dingtalk.com
*  start date: Apr 12 01:56:07 2022 GMT
*  expire date: May 14 01:56:06 2023 GMT
*  issuer: C=BE; O=GlobalSign nv-sa; CN=GlobalSign Organization Validation CA - SHA256 - G2
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x7fa774011000)
> POST /robot/send?access_token=a611ce2e561db7217aef913a14a2b80a89f747179d0b9cf32f61e6dc8d367dd8 HTTP/2
> Host: oapi.dingtalk.com
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Type: application/json
> Content-Length: 148
> 
* Connection state changed (MAX_CONCURRENT_STREAMS == 128)!
* We are completely uploaded and fine
< HTTP/2 200 
< server: Tengine
< date: Fri, 04 Nov 2022 02:51:17 GMT
< content-type: application/json
< content-length: 27
< cache-control: no-cache
< 
* Connection #0 to host oapi.dingtalk.com left intact
{"errcode":0,"errmsg":"ok"}* Closing connection 0
hfbdeMacBook-Pro:~ hfb$ 

```

## Makefile简化,只保留go语言镜像制作部分


## 以下是开源部分的原文
## 以下是开源部分的原文
## 以下是开源部分的原文

# prometheus-webhook-dingtalk
[![Build Status](https://img.shields.io/circleci/build/github/timonwong/prometheus-webhook-dingtalk)](https://circleci.com/gh/timonwong/prometheus-webhook-dingtalk)
[![Go Report Card](https://goreportcard.com/badge/github.com/timonwong/prometheus-webhook-dingtalk)](https://goreportcard.com/report/github.com/timonwong/prometheus-webhook-dingtalk)
[![Docker Pulls](https://img.shields.io/docker/pulls/timonwong/prometheus-webhook-dingtalk)](https://hub.docker.com/r/timonwong/prometheus-webhook-dingtalk)

Generating [DingTalk] notification from [Prometheus] [AlertManager] WebHooks.

## Install

### Precompiled binaries

Precompiled binaries for released versions are available in [release page](https://github.com/timonwong/prometheus-webhook-dingtalk/releases):
It's always recommended to use latest stable version available.

### Docker

You can deploy this tool using the Docker image from following registry:

* DockerHub: [timonwong/prometheus-webhook-dingtalk](https://hub.docker.com/r/timonwong/prometheus-webhook-dingtalk)

### Building from Source

#### Prerequisites

1. [Go](https://golang.org/doc/install) (1.17 or greater is required)
2. [Nodejs](https://nodejs.org/)

#### Build

Clone the repository and build manually:

```bash
make build
```

### Building the Docker Image

In order to build the docker image locally (linux/amd64), you can use the following commands:

```bash
make promu
promu crossbuild -p linux/amd64   #  Or $(go env GOPATH)/bin/promu crossbuild -p linux/amd64
make common-docker-amd64
```

## Usage

```
usage: prometheus-webhook-dingtalk [<flags>]

Flags:
  -h, --help                    Show context-sensitive help (also try --help-long and --help-man).
      --web.listen-address=:8060
                                The address to listen on for web interface.
      --web.enable-ui           Enable Web UI mounted on /ui path
      --web.enable-lifecycle    Enable reload via HTTP request.
      --config.file=config.yml  Path to the configuration file.
      --log.level=info          Only log messages with the given severity or above. One of: [debug, info, warn, error]
      --log.format=logfmt       Output format of log messages. One of: [logfmt, json]
      --version                 Show application version.
```

For Kubernetes users, check out [./contrib/k8s](./contrib/k8s).

## Configuration

常见问题可以看看 [FAQ](./docs/FAQ_zh.md)

```yaml
## Request timeout
# timeout: 5s

## Customizable templates path
# templates:
#   - contrib/templates/legacy/template.tmpl

## You can also override default template using `default_message`
## The following example to use the 'legacy' template from v0.3.0
# default_message:
#   title: '{{ template "legacy.title" . }}'
#   text: '{{ template "legacy.content" . }}'

## Targets, previously was known as "profiles"
targets:
  webhook1:
    url: https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxxxxxx
    # secret for signature
    secret: SEC000000000000000000000
  webhook2:
    url: https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxxxxxx
  webhook_legacy:
    url: https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxxxxxx
    # Customize template content
    message:
      # Use legacy template
      title: '{{ template "legacy.title" . }}'
      text: '{{ template "legacy.content" . }}'
  webhook_mention_all:
    url: https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxxxxxx
    mention:
      all: true
  webhook_mention_users:
    url: https://oapi.dingtalk.com/robot/send?access_token=xxxxxxxxxxxx
    mention:
      mobiles: ['156xxxx8827', '189xxxx8325']
```

[Prometheus]: https://prometheus.io
[AlertManager]: https://github.com/prometheus/alertmanager
[DingTalk]: https://www.dingtalk.com

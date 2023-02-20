
image: build
	docker image build -t hefabao/prometheus-webhook-dingtalk:v0.0.8 .
	docker push hefabao/prometheus-webhook-dingtalk:v0.0.8

build:
	echo "简化只编译go"
	docker run --rm --env CGO_ENABLED=0 -v /root/lts/my-prometheus-webhook-dingtalk:/usr/src/mygoapp -w /usr/src/mygoapp golang:1.18 /bin/sh -c "export GOPROXY=\"https://goproxy.cn,direct\" && echo 111 && which go&&ls && export CGO_ENABLED=0  &&go build -ldflags '-s' -v -o prometheus-webhook-dingtalk cmd/prometheus-webhook-dingtalk/main.go "


onlyimage:
	docker image build -t hefabao/prometheus-webhook-dingtalk:v0.0.8 .
	docker push hefabao/prometheus-webhook-dingtalk:v0.0.8




onlygo:
	echo "简化只编译go"
	docker run --rm --env CGO_ENABLED=0 -v $(shell pwd):/usr/src/mygoapp -w /usr/src/mygoapp golang:1.18 go build -ldflags '-s' -v cmd/prometheus-webhook-dingtalk -o prometheus-webhook-dingtalk


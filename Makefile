dock := docker run -it --rm --user `id -u` -v `pwd`:/go/src/github.com/slackhq/go-audit -w /go/src/github.com/slackhq/go-audit golang:1.7
vend := docker run -it --rm --user `id -u` -v `pwd`:/go/src/github.com/slackhq/go-audit -w /go/src/github.com/slackhq/go-audit trifs/govendor

vendor-sync:
	$(vend) sync

bin: vendor-sync
	$(dock) go build

docker: bin
	docker build -t tam7t/go-audit .

test:
	govendor sync
	go test -v

test-cov-html:
	go test -coverprofile=coverage.out
	go tool cover -html=coverage.out

bench:
	go test -bench=.

bench-cpu:
	go test -bench=. -benchtime=5s -cpuprofile=cpu.pprof
	go tool pprof go-audit.test cpu.pprof

bench-cpu-long:
	go test -bench=. -benchtime=60s -cpuprofile=cpu.pprof
	go tool pprof go-audit.test cpu.pprof

.PHONY: test test-cov-html bench bench-cpu bench-cpu-long bin vendor-sync docker
.DEFAULT_GOAL := bin

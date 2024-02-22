BOX_VERSION=0.0.1
PWD:=$(shell pwd)

.PHONY=build-docker
build-docker: Dockerfile entrypoint.sh
	BOX_VERSION=$(BOX_VERSION) docker build -t nemok/nemo-k-the-box:$(BOX_VERSION) .
	docker tag nemok/nemo-k-the-box:$(BOX_VERSION) nemok/nemo-k-the-box:latest
	: > $@

.PHONY=push-docker
push-docker: build-docker
	docker push nemok/nemo-k-the-box:$(BOX_VERSION)
	docker push nemok/nemo-k-the-box:latest
	: > $@

.PHONY=run-docker
run-docker:
	-mkdir temp/
	-mkdir artefacts/
	-docker rm nemo-k-the-box
	env | grep -P ^NEMOK_ >temp/docker-nemok-vars
	docker run --name nemo-k-the-box \
		-v $(PWD)/artefacts:/artefacts \
		--env-file temp/docker-nemok-vars \
		nemok/nemo-k-the-box:latest


IMAGE     = ssp-lab05-04_webshop-local
CONTAINER = ssp-lab05-04_webshop-local
PORT      = 8080
FLAG     ?= SSP{placeholder}

.PHONY: build run stop clean

build:
	docker build -f deploy/Dockerfile \
	    --build-arg FLAG='$(FLAG)' \
	    -t $(IMAGE) .

run: build
	@docker rm -f $(CONTAINER) 2>/dev/null || true
	docker run -d --rm -p 127.0.0.1:$(PORT):80 --name $(CONTAINER) $(IMAGE)
	@echo "http://127.0.0.1:$(PORT)"

stop:
	-docker stop $(CONTAINER)

clean: stop
	-docker rmi $(IMAGE)

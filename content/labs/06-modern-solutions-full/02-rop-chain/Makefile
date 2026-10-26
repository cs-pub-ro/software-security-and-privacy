IMAGE     = ssp-lab06-02_rop-chain-local
CONTAINER = ssp-lab06-02_rop-chain-local
PORT      = 10020
EXEC      = vuln
FLAG     ?= SSP{placeholder}

.PHONY: build run stop clean

build:
	docker build -t $(IMAGE)-builder build/
	docker run --rm -v "$(CURDIR)/build:/build" $(IMAGE)-builder make
	mkdir -p publish
	cp build/$(EXEC) publish/$(EXEC)
	docker build -f deploy/Dockerfile \
	    --build-arg FLAG_VALUES='$(FLAG)' \
	    -t $(IMAGE) .

run: build
	@docker rm -f $(CONTAINER) 2>/dev/null || true
	docker run -d --rm -p 127.0.0.1:$(PORT):31337 --name $(CONTAINER) $(IMAGE)
	@echo "nc 127.0.0.1 $(PORT)"

stop:
	-docker stop $(CONTAINER)

clean: stop
	-docker rmi $(IMAGE) $(IMAGE)-builder
	-rm -f build/$(EXEC) publish/$(EXEC)

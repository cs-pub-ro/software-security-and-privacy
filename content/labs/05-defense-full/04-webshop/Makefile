PORT        = 8080
FLAG       ?= SSP{placeholder}
DB_PASSWORD ?= CTF_DB_PASSWORD

.PHONY: run stop clean

run:
	FLAG='$(FLAG)' DB_PASSWORD='$(DB_PASSWORD)' \
	    docker compose -f deploy/docker-compose.yml up --build -d
	@echo "http://127.0.0.1:$(PORT)"

stop:
	docker compose -f deploy/docker-compose.yml down

clean: stop
	docker compose -f deploy/docker-compose.yml down --rmi local

DC=docker-compose -f docker-compose.yaml

MAKEFLAGS += --silent
path := .

.PHONY: help
help: ## 지금 보고계신 도움말
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: up
up: ## 컨테이너를 실행합니다.
	$(DC) up -d

.PHONY: down
down: ## 컨테이너를 종료합니다.
	$(DC) down --remove-orphans

.PHONY: build
build: ## 컨테이너를 빌드합니다.
	$(DC) build

.PHONY: logs
logs: ## 컨테이너 로그를 보여줍니다.
	$(DC) logs -f

.PHONY: ps
ps: ## 컨테이너 상태를 보여줍니다.
	$(DC) ps

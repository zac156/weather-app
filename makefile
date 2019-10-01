APP_NAME = "weather"

help:
	@echo "$(APP_NAME)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build the Docker image
	docker build -t $(APP_NAME):latest .

run: ## Run the app in Docker
	docker run --env-file .env --expose 4000 -p 4000:4000 --rm -it $(APP_NAME):latest

tests: ## Run tests in Docker
	docker run -e "MIX_ENV=test" --rm -it $(APP_NAME):latest mix test

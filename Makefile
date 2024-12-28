default: help

dev: ## Run rails and shaka
	make -j 2 rails shaka

rails: ## Rails server
	@bin/setup
	@bundle exec rails s

shaka: ## Shakapacker dev server
	@bin/shakapacker-dev-server

lint: ## Lint offences detected by rubocop
	@bundle exec rubocop -x

reset-db: ## Drop, Create, Migrate, Seed DB
	@bundle install
	@rails db:drop
	@rails db:create
	@rails db:migrate
	@rails db:seed

help: ## Display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

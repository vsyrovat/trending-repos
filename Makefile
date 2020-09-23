.PHONY: help
help:
	@echo "Targets: build, test, migrate"

.PHONY: build
build:
	mix deps.clean --unused
	mix deps.get
	mix deps.compile

.PHONY: test
test:
	mix format --check-formatted --dry-run
	mix clean && mix compile --warnings-as-errors
	mix test
	mix credo --strict
	mix dialyzer

.PHONY: migrate
migrate:
	mix ecto.migrate --log-sql

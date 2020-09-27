.PHONY: help
help:
	@echo "Targets: build, test, migrate"

.PHONY: build
build:
	mix deps.clean --unused
	mix deps.get
	mix deps.compile
	npm i --prefix assets

.PHONY: clean
clean:
	rm -rf _build .elixir_ls deps priv/plts priv/static

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

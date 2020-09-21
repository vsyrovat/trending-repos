.PHONY: help
help:
	@echo "Targets: build, test"

.PHONY: build
build:
	mix deps.clean --unused
	mix deps.get
	mix deps.compile

.PHONY: test
test:
	mix format --check-formatted --dry-run
	mix test
	mix credo --strict

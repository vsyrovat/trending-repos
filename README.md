# GitHub Trending Repositories API

There is GitHub trending repositories list: <https://github.com/trending>.
Unfortunally GitHub does not provide any JSON-like API for retrieving trending repositories.

This application takes that page and provides trending repositories via JSON API.

## Requirements

- For development: bash, asdf-vm with erlang/elixir/nodejs plugins, docker, docker compose. Code editor which you like. Linux recommended.
- For build release: bash, docker. Linux recommended.
- For production: bash, postgresql, docker, docker compose. Linux recommended. Reverse proxy is on your own.

## Development

- Run `asdf install` for install erlang, elixir, nodejs.
- Run `make build` for fetch and compile dependencies.
- Run `dev/up` for start developer's Postgres. Tune port in `dev/.vars` if need.
- Run `mix ecto.migrate` for apply migrations.
- Run `mix phx.server` and open `http://localhost:4000` in your browser.
- See logs in console.

- Run `make test` for tests.

## Build release and deploy to production

- Prepare remote host with ssh access by rsa key without password.
- Prepare domain name. Ssl cert is up to you.
- Choose some port, 4000 for example, and set up reverse proxy from 80/443 on it.
- Set up postgres, database should exists.
- Create target file based on `deploy/sample-target.env`.
- Run `deploy/bin/build`.
- Run `deploy/bin/deploy -t your-target-file.env`. Migrations will be applied automatically.
- Open your site in browser.
- Run `deploy/bin/clean` for clean up local artifacts.

## Some details

- GitHub provides API token for many requests allowed. This application not use such token because trending list contains ~ 25 repos, when tokenless limit is 60 per hour. Default refresh time is 60 minutes.
- Trending repositories list on GitHub has date range parameter. Because this application is implementation of test task - if fetch only one date range - daily.

## Licence

MIT

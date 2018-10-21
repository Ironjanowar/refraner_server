# It is taken from the environment, or "dev" by default
MIX_ENV ?= dev

compile: _build/$(MIX_ENV)

run: _build/$(MIX_ENV)
	mix phx.server

clean:
	rm -rf _build

.PHONY: compile run clean


## Not phony

_build/$(MIX_ENV):
	mix local.hex --force
	mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
	mix local.rebar --force
	mix deps.get
	mix compile

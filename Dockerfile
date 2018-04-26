FROM elixir:1.6.4

WORKDIR /app

ADD mix.exs mix.exs
RUN mix local.hex --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez && \
    mix local.rebar --force && \
    mix deps.get

ADD . .

RUN mix compile

ENTRYPOINT ["/app/docker_entrypoint.sh"]

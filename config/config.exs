# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :refraner_server, RefranerServer.Repo,
  adapter: Sqlite.Ecto2,
  database: "refraner.db"

# General application configuration
config :refraner_server, ecto_repos: [RefranerServer.Repo]

# Configures the endpoint
config :refraner_server, RefranerServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6tvWxh1dU9t7Ehsjz39GmzCIw2mUQnRPXDel0trDlUcYjpiwH9T7FVr3Ul9zZX2R",
  render_errors: [view: RefranerServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: RefranerServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

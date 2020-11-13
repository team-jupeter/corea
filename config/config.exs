# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :corea,
  ecto_repos: [Corea.Repo]

# Configures the endpoint
config :corea, CoreaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DypZ6GnHvwbbtrCkJbEhyPo5xBuCgk3LVUI8ChLAzQ0AMKhWQLUqVApBUpY7xl/L",
  render_errors: [view: CoreaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Corea.PubSub,
  live_view: [signing_salt: "7UJNkBV6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

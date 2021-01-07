# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :roveronline,
  ecto_repos: [Roveronline.Repo]

# Configures the endpoint
config :roveronline, RoveronlineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g5VomUZGg1osi6e0cgBk7micsbwUgD8eITUAFtgxSpngWnt/M1OVBlglK9Ev+B5p",
  render_errors: [view: RoveronlineWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Roveronline.PubSub,
  live_view: [signing_salt: "t/hwLVzN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

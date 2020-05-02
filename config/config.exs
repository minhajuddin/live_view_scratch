# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_view_scratch,
  ecto_repos: [LiveViewScratch.Repo]

# Configures the endpoint
config :live_view_scratch, LiveViewScratchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5+UMW5s2q1NXLyKB4nBBnBjFxlQMWLhnzb/ohmKX/Fuw+/NIraIEc2jhDT7x5dps",
  render_errors: [view: LiveViewScratchWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveViewScratch.PubSub,
  live_view: [signing_salt: "bGOVs/Ip"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

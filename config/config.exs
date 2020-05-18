# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :dino_tasks,
  ecto_repos: [DinoTasks.Repo],
  generators: [binary_id: true]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the endpoint
config :dino_tasks, DinoTasksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GaXm0UQ4WKocSwFelYUvI0vH9pywKil7MDnGySjqMOYwEUo4p1YwIZylDRMQcPmI",
  render_errors: [view: DinoTasksWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: DinoTasks.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config LiveView
config :dino_tasks, DinoTasksWeb.Endpoint,
  live_view: [
    signing_salt: "UONoEnZKRNlQh4/5VCYsEyAPHa81zwJa"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

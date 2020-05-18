import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dino_tasks, DinoTasks.Repo,
  username: "postgres",
  password: "postgres",
  database: "dino_tasks_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: 54323,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dino_tasks, DinoTasksWeb.Endpoint,
  http: [port: 4012],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

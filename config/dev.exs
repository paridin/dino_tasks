import Config

# Configure your database
config :dino_tasks, DinoTasks.Repo,
  username: "postgres",
  password: "postgres",
  database: "dino_tasks_dev",
  hostname: "localhost",
  port: 54323,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :dino_tasks, DinoTasksWeb.Endpoint,
  http: [port: 4010],
  https: [
    # if you are on linux be sure your user has permission on 443. (windows user please give me feedback.)
    # otherwise you can set HTTPS_PORT on your profile `.bash_profile`, `.zsh_profile` etc.
    # example:
    # export HTTPS_PORT=4443
    # then run. another way is during the execution
    # HTTPS_PORT=4443 mix phx.server
    port: String.to_integer(System.get_env("HTTPS_PORT", "4011")),
    otp_app: :dino_tasks,
    certfile: "priv/ssl/dino_tasks.pem",
    keyfile: "priv/ssl/dino_tasks_key.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :dino_tasks, DinoTasksWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/dino_tasks_web/(live|views)/.*(ex)$",
      ~r"lib/dino_tasks_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

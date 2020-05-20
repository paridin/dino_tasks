defmodule DinoTasks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    _children = [
      # Start the Ecto repository
      DinoTasks.Repo,
      # Start the Telemetry supervisor
      DinoTasksWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DinoTasks.PubSub},
      # Start the Endpoint (http/https)
      DinoTasksWeb.Endpoint
      # Start a worker by calling: DinoTasks.Worker.start_link(arg)
      # {DinoTasks.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DinoTasks.Supervisor]
    # for testing I need to uncomment the _children and pass to start_link
    Supervisor.start_link([], opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DinoTasksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

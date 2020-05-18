defmodule DinoTasks.Repo do
  use Ecto.Repo,
    otp_app: :dino_tasks,
    adapter: Ecto.Adapters.Postgres
end

defmodule Mix.Tasks.Dino do
  use Mix.Task

  @shortdoc "Prints Dino help information (Based on Phoenix Framework tasks, it was customized using the dino style)."

  @moduledoc """
  Prints Phoenix tasks and their information.
      mix dino
  """

  @doc false
  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise "Invalid arguments, expected: mix dino."
    end
  end

  defp general() do
    Application.ensure_all_started(:phoenix)
    Mix.shell().info "Phoenix v#{Application.spec(:phoenix, :vsn)}"
    Mix.shell().info "Productive. Reliable. Fast."
    Mix.shell().info "A productive web framework that does not compromise speed or maintainability."
    Mix.shell().info "\nAvailable tasks:\n"
    Mix.Tasks.Help.run(["--search", "dino."])
  end
end

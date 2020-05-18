Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  inspect: [limit: :infinity, pretty: true],
  colors: [enabled: true],
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      :magenta,
      # IEx prompt variable
      "%prefix",
      # plain string
      ">",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)

# You can add here code to work during your iex session.
# aliases could help you to your daily work.
alias Wallet.Repo
alias Phoenix.PubSub

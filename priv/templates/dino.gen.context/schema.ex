defmodule <%= inspect schema.module %> do
  @moduledoc """
  Context for <%= schema.human_singular %>.
  """
  alias <%= inspect schema.repo %>
  alias <%= inspect Module.concat(context.module, "Schema.#{schema.human_singular}") %>

  @doc """
  Returns the list of <%= schema.plural %>.
  ## Examples
      iex> list_<%= schema.plural %>()
      [%<%= inspect schema.alias %>{}, ...]
  """
  def list_<%= schema.plural %> do
    Repo.all(<%= inspect schema.alias %>)
  end

  @doc """
  Gets a single <%= schema.singular %>.
  Raises `Ecto.NoResultsError` if the <%= schema.human_singular %> does not exist.
  ## Examples
      iex> get_<%= schema.singular %>!(123)
      %<%= inspect schema.alias %>{}
      iex> get_<%= schema.singular %>!(456)
      ** (Ecto.NoResultsError)
  """
  def get_<%= schema.singular %>!(id), do: Repo.get!(<%= inspect schema.alias %>, id)
  def get_<%= schema.singular %>(params), do: Repo.get(<%= inspect schema.alias %>, params)
  def get_<%= schema.singular %>_by(params), do: Repo.get_by(<%= inspect schema.alias %>, params)

  @doc """
  Creates a <%= schema.singular %>.
  ## Examples
      iex> create_<%= schema.singular %>(%{field: value})
      {:ok, %<%= inspect schema.alias %>{}}
      iex> create_<%= schema.singular %>(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_<%= schema.singular %>(params \\ %{}) do
    %<%= inspect schema.alias %>{}
    |> <%= inspect schema.alias %>.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates a <%= schema.singular %>.
  ## Examples
      iex> update_<%= schema.singular %>(<%= schema.singular %>, %{field: new_value})
      {:ok, %<%= inspect schema.alias %>{}}
      iex> update_<%= schema.singular %>(<%= schema.singular %>, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_<%= schema.singular %>(%<%= inspect schema.alias %>{} = <%= schema.singular %>, params) do
    <%= schema.singular %>
    |> <%= inspect schema.alias %>.changeset(params)
    |> Repo.update()
  end

  @doc """
  Deletes a <%= schema.singular %>.
  ## Examples
      iex> delete_<%= schema.singular %>(<%= schema.singular %>)
      {:ok, %<%= inspect schema.alias %>{}}
      iex> delete_<%= schema.singular %>(<%= schema.singular %>)
      {:error, %Ecto.Changeset{}}
  """
  def delete_<%= schema.singular %>(%<%= inspect schema.alias %>{} = <%= schema.singular %>) do
    Repo.delete(<%= schema.singular %>)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking <%= schema.singular %> changes.
  ## Examples
      iex> change_<%= schema.singular %>(<%= schema.singular %>)
      %Ecto.Changeset{data: %<%= inspect schema.alias %>{}}
  """
  def change_<%= schema.singular %>(%<%= inspect schema.alias %>{} = <%= schema.singular %>, params \\ %{}) do
    <%= inspect schema.alias %>.changeset(<%= schema.singular %>, params)
  end
end

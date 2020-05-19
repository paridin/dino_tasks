defmodule <%= inspect Module.concat(context.module, "Schema.#{schema.human_singular}") %> do
  @moduledoc """
  <%= inspect Module.concat("Schema", schema.human_singular) %> module.
  """

  use Ecto.Schema
  import Ecto.Changeset
<%= if schema.binary_id do %>
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id<% end %>
  schema <%= inspect schema.table %> do
<%= for {k, v} <- schema.types do %>    field <%= inspect k %>, <%= inspect v %><%= schema.defaults[k] %>
<% end %><%= for {_, k, _, _} <- schema.assocs do %>    field <%= inspect k %>, <%= if schema.binary_id do %>:binary_id<% else %>:id<% end %>
<% end %>
    timestamps()
  end

  @doc false
  def new_changeset(params) do
    %__MODULE__{}
    |> changeset(params)
  end

  @doc false
  def preload(%__MODULE__{} = <%= schema.singular %>, params) do
    <%= schema.singular %>
    |> <%= inspect schema.repo %>.preload(params)
  end

  @doc false
  def changeset(<%= schema.singular %>, params) do
    <%= schema.singular %>
    |> cast(params, [<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
    |> validate_required([<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>])
<%= for k <- schema.uniques do %>    |> unique_constraint(<%= inspect k %>)
<% end %>  end
end

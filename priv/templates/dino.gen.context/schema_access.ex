
  alias <%= inspect schema.module %>

  defdelegate list_<%= schema.plural %>(), to: <%= inspect schema.alias %>
  defdelegate get_<%= schema.singular %>!(id), to: <%= inspect schema.alias %>
  defdelegate get_<%= schema.singular %>(params), to: <%= inspect schema.alias %>
  defdelegate get_by<%= schema.singular %>(params), to: <%= inspect schema.alias %>
  defdelegate create_<%= schema.singular %>(params), to: <%= inspect schema.alias %>
  defdelegate update_<%= schema.singular %>(<%= schema.singular %>, params), to: <%= inspect schema.alias %>
  defdelegate delete_<%= schema.singular %>(<%= schema.singular %>), to: <%= inspect schema.alias %>

  defdelegate change_<%= schema.singular %>(<%= schema.singular %>), to: <%= inspect schema.alias %>
  defdelegate change_<%= schema.singular %>(<%= schema.singular %>, params), to: <%= inspect schema.alias %>

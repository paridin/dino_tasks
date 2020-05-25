defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(Live, context.name) %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>.Index do
  @moduledoc """
  Index for <%= inspect Module.concat(schema.web_namespace, schema.alias) %>
  """
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.module %>
  alias <%= inspect Module.concat(context.module, "Schema.#{schema.human_singular}") %>

  @impl true
  def render(assigns) do
    ~L"""
    <div>
      <%%= if @live_action in [:new, :edit] do %>
        <%%= live_modal @socket, <%= inspect context.web_module %>.<%= inspect Module.concat(Live, context.name) %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>.FormComponent,
          id: @<%= schema.singular %>.id || :new,
          title: @page_title,
          action: @live_action,
          <%= schema.singular %>: @<%= schema.singular %>,
          return_to: Routes.<%= schema.route_helper %>_index_path(@socket, :index) %>
      <%% end %>

      <div class="px-4 py-5 bg-white border-b border-gray-200 sm:px-6">
        <div class="flex flex-wrap items-center justify-between -mt-2 -ml-4 sm:flex-no-wrap">
          <div class="mt-2 ml-4">
            <h3 class="text-lg font-medium leading-6 text-gray-900">Listing <%= schema.human_plural %></h3>
          </div>
          <div class="flex-shrink-0 mt-2 ml-4">
            <span class="inline-flex rounded-md shadow-sm">
              <button type="button" class="relative inline-flex items-center px-4 py-2 text-sm font-medium leading-5 text-white transition duration-150 ease-in-out bg-green-600 border border-transparent rounded-md hover:bg-green-500 focus:outline-none focus:border-green-700 focus:shadow-outline-green active:bg-green-700">
                <%%= live_patch "New <%= schema.human_singular %>", to: Routes.<%= schema.route_helper %>_index_path(@socket, :new) %>
              </button>
            </span>
          </div>
        </div>
      </div>

      <div class="flex flex-col">
        <div class="py-2 overflow-x-auto sm:px-6 lg:px-8">
          <div class="inline-block min-w-full overflow-hidden align-middle border-b border-gray-200 shadow sm:rounded-lg">
            <table class="min-w-full">
              <thead>
                <tr>
                  <%= for {k, _} <- schema.attrs do %>
                  <th class="px-6 py-3 text-xs font-medium leading-4 tracking-wider text-left text-gray-500 uppercase border-b border-gray-200 bg-gray-50"><%= Phoenix.Naming.humanize(Atom.to_string(k)) %></th>
                  <% end %>
                  <th class="px-6 py-3 border-b border-gray-200 bg-gray-50"></th>
                </tr>
              </thead>
              <tbody id="<%= schema.plural %>">
                <%%= for <%= schema.singular %> <- @<%= schema.plural %> do %>
                  <tr id="<%= schema.singular %>-<%%= <%= schema.singular %>.id %>">
                    <%= for {k, _} <- schema.attrs do %>
                    <td class="px-6 py-4 text-sm font-medium leading-5 text-gray-500"><%%= <%= schema.singular %>.<%= k %> %></td>
                    <% end %>
                    <td class="px-6 py-4 text-sm font-medium leading-5 text-right whitespace-no-wrap">
                      <span><%%= live_redirect "Show", to: Routes.<%= schema.route_helper %>_show_path(@socket, :show, <%= schema.singular %>) %></span>
                      <span><%%= live_patch "Edit", to: Routes.<%= schema.route_helper %>_index_path(@socket, :edit, <%= schema.singular %>) %></span>
                      <span><%%= link "Delete", to: "#", phx_click: "delete", phx_value_id: <%= schema.singular %>.id, data: [confirm: "Are you sure?"] %></span>
                    </td>
                  </tr>
                <%% end %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :<%= schema.plural %>, list_<%= schema.plural %>())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit <%= schema.human_singular %>")
    |> assign(:<%= schema.singular %>, <%= inspect context.alias %>.get_<%= schema.singular %>!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New <%= schema.human_singular %>")
    |> assign(:<%= schema.singular %>, %<%= inspect schema.alias %>{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing <%= schema.human_plural %>")
    |> assign(:<%= schema.singular %>, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>!(id)
    {:ok, _} = <%= inspect context.alias %>.delete_<%= schema.singular %>(<%= schema.singular %>)

    {:noreply, assign(socket, :<%= schema.plural %>, list_<%=schema.plural %>())}
  end

  defp list_<%= schema.plural %> do
    <%= inspect context.alias %>.list_<%= schema.plural %>()
  end
end

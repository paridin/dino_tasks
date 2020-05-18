defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(Live, context.name) %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %> do
  @moduledoc """
  live view for <%= inspect Module.concat(schema.web_namespace, schema.alias) %>
  """
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.module %>

  @impl true
  def render(assigns) do
    ~L"""
    <div>
      <%%= if @live_action in [:edit] do %>
        <%%= live_modal @socket, <%= inspect context.web_module %>.<%= inspect Module.concat(Live, context.name) %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>.FormComponent,
          id: @<%= schema.singular %>.id,
          title: @page_title,
          action: @live_action,
          <%= schema.singular %>: @<%= schema.singular %>,
          return_to: Routes.<%= schema.route_helper %>_show_path(@socket, :show, @<%= schema.singular %>) %>
      <%% end %>
      <div class="overflow-hidden bg-white shadow sm:rounded-lg">
        <div class="px-4 py-5 border-b border-gray-200 sm:px-6">
          <div class="flex justify-between">
            <h3 class="text-lg font-medium leading-6 text-gray-900">Show <%= schema.human_singular %></h3>
            <nav class="flex">
              <%%= live_patch "Edit",
                to: Routes.<%= schema.route_helper %>_show_path(@socket, :edit, @<%= schema.singular %>),
                class: "inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150" %>
              <%%= live_redirect "Back",
                to: Routes.<%= schema.route_helper %>_index_path(@socket, :index),
                class: "inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-50 focus:outline-none focus:border-indigo-300 focus:shadow-outline-indigo active:bg-indigo-200 transition ease-in-out duration-150" %>
            </nav>
          </div>
          <p class="max-w-2xl -mt-2 text-sm leading-5 text-gray-500">
            <%= schema.human_singular %> details.
          </p>
        </div>
        <div class="px-4 py-5 sm:px-6">
          <dl class="grid grid-cols-1 row-gap-8 col-gap-4 sm:grid-cols-2">
            <%= for {k, _} <- schema.attrs do %>
              <div class="sm:col-span-1">
                <dt class="text-sm font-medium leading-5 text-gray-500">
                  <%= Phoenix.Naming.humanize(Atom.to_string(k)) %>
                </dt>
                <dd class="mt-1 text-sm leading-5 text-gray-900">
                  <%%= @<%= schema.singular %>.<%= k %> %>
                </dd>
              </div>
            <% end %>
          </dl>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:<%= schema.singular %>, <%= inspect context.alias %>.get_<%= schema.singular %>!(id))}
  end

  defp page_title(:show), do: "Show <%= schema.human_singular %>"
  defp page_title(:edit), do: "Edit <%= schema.human_singular %>"
end

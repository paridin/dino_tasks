defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(Live, context.name) %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>.FormComponent do
  @moduledoc """
  Form component for <%= inspect Module.concat(schema.web_namespace, schema.alias) %>
  """
  use <%= inspect context.web_module %>, :live_component

  alias <%= inspect context.module %>

  @impl true
  def render(assigns) do
    ~L"""
    <div class="px-4 pt-8">
      <div class="mt-3">
        <h3 class="text-lg font-medium leading-6 text-gray-900" id="modal-headline"><%%= @title %></h3>
      </div>
      <%%= f = form_for @changeset, "#",
        id: "<%= schema.singular %>-form",
        phx_target: @myself,
        phx_change: "validate",
        phx_submit: "save" %>
        <%= for {label, input, error} <- inputs, input do %>
        <div class="mt-6">
          <%= label %>
          <div class="mt-1 sm:mt-0 sm:col-span-2">
            <div class="flex max-w-lg rounded-md shadow-sm">
              <%= input %>
            </div>
          </div>
          <%= error %>
        </div>
        <% end %>
        <%%= submit "Save", phx_disable_with: "Saving...",
          class: "inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150" %>
      </form>
    </div>
    """
  end

  @impl true
  def update(%{<%= schema.singular %>: <%= schema.singular %>} = assigns, socket) do
    changeset = <%= inspect context.alias %>.change_<%= schema.singular %>(<%= schema.singular %>)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"<%= schema.singular %>" => <%= schema.singular %>_params}, socket) do
    changeset =
      socket.assigns.<%= schema.singular %>
      |> <%= inspect context.alias %>.change_<%= schema.singular %>(<%= schema.singular %>_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"<%= schema.singular %>" => <%= schema.singular %>_params}, socket) do
    save_<%= schema.singular %>(socket, socket.assigns.action, <%= schema.singular %>_params)
  end

  defp save_<%= schema.singular %>(socket, :edit, <%= schema.singular %>_params) do
    case <%= inspect context.alias %>.update_<%= schema.singular %>(socket.assigns.<%= schema.singular %>, <%= schema.singular %>_params) do
      {:ok, _<%= schema.singular %>} ->
        {:noreply,
         socket
         |> put_flash(:info, "<%= schema.human_singular %> updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_<%= schema.singular %>(socket, :new, <%= schema.singular %>_params) do
    case <%= inspect context.alias %>.create_<%= schema.singular %>(<%= schema.singular %>_params) do
      {:ok, _<%= schema.singular %>} ->
        {:noreply,
         socket
         |> put_flash(:info, "<%= schema.human_singular %> created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

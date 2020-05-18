
defmodule <%= inspect context.web_module %>.ModalComponent do
  @moduledoc """
  Modal Component
  """
  use <%= inspect context.web_module %>, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%%= @id %>" class="fixed inset-x-0 bottom-0 z-50 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%%= @id %>"
      phx-page-loading>
      <div class="fixed inset-0 transition-opacity">
        <div class="absolute inset-0 bg-gray-900 opacity-75"></div>
      </div>

      <div class="overflow-hidden transition-all transform bg-white rounded-lg shadow-xl sm:max-w-lg sm:w-full" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
        <div class="absolute top-0 right-0 hidden pt-4 pr-4 sm:block">
          <%%= live_patch raw(~e[<svg class="w-6 h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>]),
            to: @return_to,
            class: "text-gray-400 transition duration-150 ease-in-out hover:text-gray-500 focus:outline-none focus:text-gray-500", aria_label: "Close" %>
        </div>
        <%%= live_component @socket, @component, @opts %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end

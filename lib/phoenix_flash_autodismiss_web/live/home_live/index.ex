defmodule PhoenixFlashAutodismissWeb.HomeLive.Index do
  use PhoenixFlashAutodismissWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center justify-center gap-4">
      <div class="flex flex-row items-center justify-center gap-2">
        <.button phx-click="info" phx-value-msg="info 1" class="!bg-blue-500 hover:!bg-blue-600">
          Info 1
        </.button>
        <.button phx-click="info" phx-value-msg="info 2" class="!bg-blue-500 hover:!bg-blue-600">
          Info 2
        </.button>
        <.button phx-click="info" phx-value-msg="info 3" class="!bg-blue-500 hover:!bg-blue-600">
          Info 3
        </.button>
      </div>
      <div class="flex flex-row items-center justify-center gap-2">
        <.button phx-click="error" phx-value-msg="error 1" class="!bg-red-500 hover:!bg-red-600">
          Error 1
        </.button>
        <.button phx-click="error" phx-value-msg="error 2" class="!bg-red-500 hover:!bg-red-600">
          Error 2
        </.button>
        <.button phx-click="error" phx-value-msg="error 3" class="!bg-red-500 hover:!bg-red-600">
          Error 3
        </.button>
      </div>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("info", %{"msg" => msg}, socket) do
    socket =
      socket
      |> put_flash(:info, msg)

    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("error", %{"msg" => msg}, socket) do
    socket =
      socket
      |> put_flash(:error, msg)

    {:noreply, socket}
  end
end

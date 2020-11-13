defmodule CoreaWeb.CarLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Cars

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:car, Cars.get_car!(id))}
  end

  defp page_title(:show), do: "Show Car"
  defp page_title(:edit), do: "Edit Car"
end

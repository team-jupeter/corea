defmodule CoreaWeb.ReservoirLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Reservoirs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:reservoir, Reservoirs.get_reservoir!(id))}
  end

  defp page_title(:show), do: "Show Reservoir"
  defp page_title(:edit), do: "Edit Reservoir"
end

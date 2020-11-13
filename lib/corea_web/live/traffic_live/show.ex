defmodule CoreaWeb.TrafficLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Traffics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:traffic, Traffics.get_traffic!(id))}
  end

  defp page_title(:show), do: "Show Traffic"
  defp page_title(:edit), do: "Edit Traffic"
end

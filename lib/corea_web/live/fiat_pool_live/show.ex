defmodule CoreaWeb.FiatPoolLive.Show do
  use CoreaWeb, :live_view

  alias Corea.FiatPools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fiat_pool, FiatPools.get_fiat_pool!(id))}
  end

  defp page_title(:show), do: "Show Fiat pool"
  defp page_title(:edit), do: "Edit Fiat pool"
end

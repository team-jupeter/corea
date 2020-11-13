defmodule CoreaWeb.T4PoolLive.Show do
  use CoreaWeb, :live_view

  alias Corea.T4Pools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t4_pool, T4Pools.get_t4_pool!(id))}
  end

  defp page_title(:show), do: "Show T4 pool"
  defp page_title(:edit), do: "Edit T4 pool"
end

defmodule CoreaWeb.T2PoolLive.Show do
  use CoreaWeb, :live_view

  alias Corea.T2Pools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t2_pool, T2Pools.get_t2_pool!(id))}
  end

  defp page_title(:show), do: "Show T2 pool"
  defp page_title(:edit), do: "Edit T2 pool"
end

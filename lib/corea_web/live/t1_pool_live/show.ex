defmodule CoreaWeb.T1PoolLive.Show do
  use CoreaWeb, :live_view

  alias Corea.T1Pools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t1_pool, T1Pools.get_t1_pool!(id))}
  end

  defp page_title(:show), do: "Show T1 pool"
  defp page_title(:edit), do: "Edit T1 pool"
end

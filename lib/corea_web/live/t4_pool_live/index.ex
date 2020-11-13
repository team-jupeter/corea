defmodule CoreaWeb.T4PoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.T4Pools
  alias Corea.T4Pools.T4Pool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t4_pools, list_t4_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T4 pool")
    |> assign(:t4_pool, T4Pools.get_t4_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T4 pool")
    |> assign(:t4_pool, %T4Pool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T4 pools")
    |> assign(:t4_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t4_pool = T4Pools.get_t4_pool!(id)
    {:ok, _} = T4Pools.delete_t4_pool(t4_pool)

    {:noreply, assign(socket, :t4_pools, list_t4_pools())}
  end

  defp list_t4_pools do
    T4Pools.list_t4_pools()
  end
end

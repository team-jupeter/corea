defmodule CoreaWeb.T3PoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.T3Pools
  alias Corea.T3Pools.T3Pool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t3_pools, list_t3_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T3 pool")
    |> assign(:t3_pool, T3Pools.get_t3_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T3 pool")
    |> assign(:t3_pool, %T3Pool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T3 pools")
    |> assign(:t3_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t3_pool = T3Pools.get_t3_pool!(id)
    {:ok, _} = T3Pools.delete_t3_pool(t3_pool)

    {:noreply, assign(socket, :t3_pools, list_t3_pools())}
  end

  defp list_t3_pools do
    T3Pools.list_t3_pools()
  end
end

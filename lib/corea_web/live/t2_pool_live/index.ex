defmodule CoreaWeb.T2PoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.T2Pools
  alias Corea.T2Pools.T2Pool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t2_pools, list_t2_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T2 pool")
    |> assign(:t2_pool, T2Pools.get_t2_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T2 pool")
    |> assign(:t2_pool, %T2Pool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T2 pools")
    |> assign(:t2_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t2_pool = T2Pools.get_t2_pool!(id)
    {:ok, _} = T2Pools.delete_t2_pool(t2_pool)

    {:noreply, assign(socket, :t2_pools, list_t2_pools())}
  end

  defp list_t2_pools do
    T2Pools.list_t2_pools()
  end
end

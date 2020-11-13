defmodule CoreaWeb.T1PoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.T1Pools
  alias Corea.T1Pools.T1Pool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t1_pools, list_t1_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T1 pool")
    |> assign(:t1_pool, T1Pools.get_t1_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T1 pool")
    |> assign(:t1_pool, %T1Pool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T1 pools")
    |> assign(:t1_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t1_pool = T1Pools.get_t1_pool!(id)
    {:ok, _} = T1Pools.delete_t1_pool(t1_pool)

    {:noreply, assign(socket, :t1_pools, list_t1_pools())}
  end

  defp list_t1_pools do
    T1Pools.list_t1_pools()
  end
end

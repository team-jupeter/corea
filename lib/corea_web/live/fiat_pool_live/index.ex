defmodule CoreaWeb.FiatPoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.FiatPools
  alias Corea.FiatPools.FiatPool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :fiat_pools, list_fiat_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fiat pool")
    |> assign(:fiat_pool, FiatPools.get_fiat_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fiat pool")
    |> assign(:fiat_pool, %FiatPool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fiat pools")
    |> assign(:fiat_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fiat_pool = FiatPools.get_fiat_pool!(id)
    {:ok, _} = FiatPools.delete_fiat_pool(fiat_pool)

    {:noreply, assign(socket, :fiat_pools, list_fiat_pools())}
  end

  defp list_fiat_pools do
    FiatPools.list_fiat_pools()
  end
end

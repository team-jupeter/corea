defmodule CoreaWeb.MoneyPoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.MoneyPools
  alias Corea.MoneyPools.MoneyPool

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :money_pools, list_money_pools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Money pool")
    |> assign(:money_pool, MoneyPools.get_money_pool!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Money pool")
    |> assign(:money_pool, %MoneyPool{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Money pools")
    |> assign(:money_pool, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    money_pool = MoneyPools.get_money_pool!(id)
    {:ok, _} = MoneyPools.delete_money_pool(money_pool)

    {:noreply, assign(socket, :money_pools, list_money_pools())}
  end

  defp list_money_pools do
    MoneyPools.list_money_pools()
  end
end

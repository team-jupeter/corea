defmodule CoreaWeb.FairTradeLive.Index do
  use CoreaWeb, :live_view

  alias Corea.FairTrades
  alias Corea.FairTrades.FairTrade

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :fair_trades, list_fair_trades())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fair trade")
    |> assign(:fair_trade, FairTrades.get_fair_trade!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fair trade")
    |> assign(:fair_trade, %FairTrade{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fair trades")
    |> assign(:fair_trade, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fair_trade = FairTrades.get_fair_trade!(id)
    {:ok, _} = FairTrades.delete_fair_trade(fair_trade)

    {:noreply, assign(socket, :fair_trades, list_fair_trades())}
  end

  defp list_fair_trades do
    FairTrades.list_fair_trades()
  end
end

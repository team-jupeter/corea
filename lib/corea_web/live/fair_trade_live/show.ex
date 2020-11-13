defmodule CoreaWeb.FairTradeLive.Show do
  use CoreaWeb, :live_view

  alias Corea.FairTrades

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fair_trade, FairTrades.get_fair_trade!(id))}
  end

  defp page_title(:show), do: "Show Fair trade"
  defp page_title(:edit), do: "Edit Fair trade"
end

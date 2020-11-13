defmodule CoreaWeb.MoneyPoolLive.Show do
  use CoreaWeb, :live_view

  alias Corea.MoneyPools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:money_pool, MoneyPools.get_money_pool!(id))}
  end

  defp page_title(:show), do: "Show Money pool"
  defp page_title(:edit), do: "Edit Money pool"
end

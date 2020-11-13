defmodule CoreaWeb.BalanceSheetLive.Show do
  use CoreaWeb, :live_view

  alias Corea.BalanceSheets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:balance_sheet, BalanceSheets.get_balance_sheet!(id))}
  end

  defp page_title(:show), do: "Show Balance sheet"
  defp page_title(:edit), do: "Edit Balance sheet"
end

defmodule CoreaWeb.SupulBalanceSheetLive.Show do
  use CoreaWeb, :live_view

  alias Corea.SupulBalanceSheets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:supul_balance_sheet, SupulBalanceSheets.get_supul_balance_sheet!(id))}
  end

  defp page_title(:show), do: "Show Supul balance sheet"
  defp page_title(:edit), do: "Edit Supul balance sheet"
end

defmodule CoreaWeb.GopangBalanceSheetLive.Show do
  use CoreaWeb, :live_view

  alias Corea.GopangBalanceSheets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gopang_balance_sheet, GopangBalanceSheets.get_gopang_balance_sheet!(id))}
  end

  defp page_title(:show), do: "Show Gopang balance sheet"
  defp page_title(:edit), do: "Edit Gopang balance sheet"
end

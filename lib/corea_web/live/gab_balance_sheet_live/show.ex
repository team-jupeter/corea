defmodule CoreaWeb.GABBalanceSheetLive.Show do
  use CoreaWeb, :live_view

  alias Corea.GABBalanceSheets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gab_balance_sheet, GABBalanceSheets.get_gab_balance_sheet!(id))}
  end

  defp page_title(:show), do: "Show Gab balance sheet"
  defp page_title(:edit), do: "Edit Gab balance sheet"
end

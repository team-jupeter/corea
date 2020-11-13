defmodule CoreaWeb.GovBalanceSheetLive.Show do
  use CoreaWeb, :live_view

  alias Corea.GovBalanceSheets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gov_balance_sheet, GovBalanceSheets.get_gov_balance_sheet!(id))}
  end

  defp page_title(:show), do: "Show Gov balance sheet"
  defp page_title(:edit), do: "Edit Gov balance sheet"
end

defmodule CoreaWeb.GovBalanceSheetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GovBalanceSheets
  alias Corea.GovBalanceSheets.GovBalanceSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gov_balance_sheets, list_gov_balance_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gov balance sheet")
    |> assign(:gov_balance_sheet, GovBalanceSheets.get_gov_balance_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gov balance sheet")
    |> assign(:gov_balance_sheet, %GovBalanceSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gov balance sheets")
    |> assign(:gov_balance_sheet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gov_balance_sheet = GovBalanceSheets.get_gov_balance_sheet!(id)
    {:ok, _} = GovBalanceSheets.delete_gov_balance_sheet(gov_balance_sheet)

    {:noreply, assign(socket, :gov_balance_sheets, list_gov_balance_sheets())}
  end

  defp list_gov_balance_sheets do
    GovBalanceSheets.list_gov_balance_sheets()
  end
end

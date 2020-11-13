defmodule CoreaWeb.GABBalanceSheetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GABBalanceSheets
  alias Corea.GABBalanceSheets.GABBalanceSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gab_balance_sheets, list_gab_balance_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gab balance sheet")
    |> assign(:gab_balance_sheet, GABBalanceSheets.get_gab_balance_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gab balance sheet")
    |> assign(:gab_balance_sheet, %GABBalanceSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gab balance sheets")
    |> assign(:gab_balance_sheet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gab_balance_sheet = GABBalanceSheets.get_gab_balance_sheet!(id)
    {:ok, _} = GABBalanceSheets.delete_gab_balance_sheet(gab_balance_sheet)

    {:noreply, assign(socket, :gab_balance_sheets, list_gab_balance_sheets())}
  end

  defp list_gab_balance_sheets do
    GABBalanceSheets.list_gab_balance_sheets()
  end
end

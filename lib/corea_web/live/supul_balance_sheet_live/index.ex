defmodule CoreaWeb.SupulBalanceSheetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.SupulBalanceSheets
  alias Corea.SupulBalanceSheets.SupulBalanceSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :supul_balance_sheets, list_supul_balance_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Supul balance sheet")
    |> assign(:supul_balance_sheet, SupulBalanceSheets.get_supul_balance_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Supul balance sheet")
    |> assign(:supul_balance_sheet, %SupulBalanceSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Supul balance sheets")
    |> assign(:supul_balance_sheet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    supul_balance_sheet = SupulBalanceSheets.get_supul_balance_sheet!(id)
    {:ok, _} = SupulBalanceSheets.delete_supul_balance_sheet(supul_balance_sheet)

    {:noreply, assign(socket, :supul_balance_sheets, list_supul_balance_sheets())}
  end

  defp list_supul_balance_sheets do
    SupulBalanceSheets.list_supul_balance_sheets()
  end
end

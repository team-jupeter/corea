defmodule CoreaWeb.BalanceSheetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.BalanceSheets
  alias Corea.BalanceSheets.BalanceSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :balance_sheets, list_balance_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Balance sheet")
    |> assign(:balance_sheet, BalanceSheets.get_balance_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Balance sheet")
    |> assign(:balance_sheet, %BalanceSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Balance sheets")
    |> assign(:balance_sheet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    balance_sheet = BalanceSheets.get_balance_sheet!(id)
    {:ok, _} = BalanceSheets.delete_balance_sheet(balance_sheet)

    {:noreply, assign(socket, :balance_sheets, list_balance_sheets())}
  end

  defp list_balance_sheets do
    BalanceSheets.list_balance_sheets()
  end
end

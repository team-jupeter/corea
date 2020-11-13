defmodule CoreaWeb.GopangBalanceSheetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GopangBalanceSheets
  alias Corea.GopangBalanceSheets.GopangBalanceSheet

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gopang_balance_sheets, list_gopang_balance_sheets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gopang balance sheet")
    |> assign(:gopang_balance_sheet, GopangBalanceSheets.get_gopang_balance_sheet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gopang balance sheet")
    |> assign(:gopang_balance_sheet, %GopangBalanceSheet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gopang balance sheets")
    |> assign(:gopang_balance_sheet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gopang_balance_sheet = GopangBalanceSheets.get_gopang_balance_sheet!(id)
    {:ok, _} = GopangBalanceSheets.delete_gopang_balance_sheet(gopang_balance_sheet)

    {:noreply, assign(socket, :gopang_balance_sheets, list_gopang_balance_sheets())}
  end

  defp list_gopang_balance_sheets do
    GopangBalanceSheets.list_gopang_balance_sheets()
  end
end

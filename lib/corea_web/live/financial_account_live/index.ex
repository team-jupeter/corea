defmodule CoreaWeb.FinancialAccountLive.Index do
  use CoreaWeb, :live_view

  alias Corea.FinancialAccounts
  alias Corea.FinancialAccounts.FinancialAccount

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :financial_accounts, list_financial_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Financial account")
    |> assign(:financial_account, FinancialAccounts.get_financial_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Financial account")
    |> assign(:financial_account, %FinancialAccount{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Financial accounts")
    |> assign(:financial_account, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    financial_account = FinancialAccounts.get_financial_account!(id)
    {:ok, _} = FinancialAccounts.delete_financial_account(financial_account)

    {:noreply, assign(socket, :financial_accounts, list_financial_accounts())}
  end

  defp list_financial_accounts do
    FinancialAccounts.list_financial_accounts()
  end
end

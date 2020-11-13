defmodule CoreaWeb.GABAccountLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GABAccounts
  alias Corea.GABAccounts.GABAccount

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gab_accounts, list_gab_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gab account")
    |> assign(:gab_account, GABAccounts.get_gab_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gab account")
    |> assign(:gab_account, %GABAccount{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gab accounts")
    |> assign(:gab_account, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gab_account = GABAccounts.get_gab_account!(id)
    {:ok, _} = GABAccounts.delete_gab_account(gab_account)

    {:noreply, assign(socket, :gab_accounts, list_gab_accounts())}
  end

  defp list_gab_accounts do
    GABAccounts.list_gab_accounts()
  end
end

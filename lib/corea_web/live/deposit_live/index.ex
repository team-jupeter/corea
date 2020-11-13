defmodule CoreaWeb.DepositLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Deposits
  alias Corea.Deposits.Deposit

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :deposits, list_deposits())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deposit")
    |> assign(:deposit, Deposits.get_deposit!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deposit")
    |> assign(:deposit, %Deposit{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Deposits")
    |> assign(:deposit, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deposit = Deposits.get_deposit!(id)
    {:ok, _} = Deposits.delete_deposit(deposit)

    {:noreply, assign(socket, :deposits, list_deposits())}
  end

  defp list_deposits do
    Deposits.list_deposits()
  end
end

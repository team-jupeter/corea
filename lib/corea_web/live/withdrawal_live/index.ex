defmodule CoreaWeb.WithdrawalLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Withdrawals
  alias Corea.Withdrawals.Withdrawal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :withdrawals, list_withdrawals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Withdrawal")
    |> assign(:withdrawal, Withdrawals.get_withdrawal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Withdrawal")
    |> assign(:withdrawal, %Withdrawal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Withdrawals")
    |> assign(:withdrawal, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    withdrawal = Withdrawals.get_withdrawal!(id)
    {:ok, _} = Withdrawals.delete_withdrawal(withdrawal)

    {:noreply, assign(socket, :withdrawals, list_withdrawals())}
  end

  defp list_withdrawals do
    Withdrawals.list_withdrawals()
  end
end

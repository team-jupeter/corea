defmodule CoreaWeb.TxnLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Txns
  alias Corea.Txns.Txn

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :txns, list_txns())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Txn")
    |> assign(:txn, Txns.get_txn!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Txn")
    |> assign(:txn, %Txn{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Txns")
    |> assign(:txn, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    txn = Txns.get_txn!(id)
    {:ok, _} = Txns.delete_txn(txn)

    {:noreply, assign(socket, :txns, list_txns())}
  end

  defp list_txns do
    Txns.list_txns()
  end
end

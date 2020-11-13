defmodule CoreaWeb.TxnLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Txns

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:txn, Txns.get_txn!(id))}
  end

  defp page_title(:show), do: "Show Txn"
  defp page_title(:edit), do: "Edit Txn"
end

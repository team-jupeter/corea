defmodule CoreaWeb.WithdrawalLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Withdrawals

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:withdrawal, Withdrawals.get_withdrawal!(id))}
  end

  defp page_title(:show), do: "Show Withdrawal"
  defp page_title(:edit), do: "Edit Withdrawal"
end

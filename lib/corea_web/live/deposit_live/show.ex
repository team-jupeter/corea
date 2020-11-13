defmodule CoreaWeb.DepositLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Deposits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deposit, Deposits.get_deposit!(id))}
  end

  defp page_title(:show), do: "Show Deposit"
  defp page_title(:edit), do: "Edit Deposit"
end

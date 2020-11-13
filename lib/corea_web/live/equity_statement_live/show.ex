defmodule CoreaWeb.EquityStatementLive.Show do
  use CoreaWeb, :live_view

  alias Corea.EquityStatements

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:equity_statement, EquityStatements.get_equity_statement!(id))}
  end

  defp page_title(:show), do: "Show Equity statement"
  defp page_title(:edit), do: "Edit Equity statement"
end

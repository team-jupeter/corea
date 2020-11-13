defmodule CoreaWeb.IncomeStatementLive.Show do
  use CoreaWeb, :live_view

  alias Corea.IncomeStatements

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:income_statement, IncomeStatements.get_income_statement!(id))}
  end

  defp page_title(:show), do: "Show Income statement"
  defp page_title(:edit), do: "Edit Income statement"
end

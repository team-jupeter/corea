defmodule CoreaWeb.FinancialReportLive.Show do
  use CoreaWeb, :live_view

  alias Corea.FinancialReports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:financial_report, FinancialReports.get_financial_report!(id))}
  end

  defp page_title(:show), do: "Show Financial report"
  defp page_title(:edit), do: "Edit Financial report"
end

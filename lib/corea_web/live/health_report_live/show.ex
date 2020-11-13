defmodule CoreaWeb.HealthReportLive.Show do
  use CoreaWeb, :live_view

  alias Corea.HealthReports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:health_report, HealthReports.get_health_report!(id))}
  end

  defp page_title(:show), do: "Show Health report"
  defp page_title(:edit), do: "Edit Health report"
end

defmodule CoreaWeb.HealthReportLive.Index do
  use CoreaWeb, :live_view

  alias Corea.HealthReports
  alias Corea.HealthReports.HealthReport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :health_reports, list_health_reports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Health report")
    |> assign(:health_report, HealthReports.get_health_report!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Health report")
    |> assign(:health_report, %HealthReport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Health reports")
    |> assign(:health_report, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    health_report = HealthReports.get_health_report!(id)
    {:ok, _} = HealthReports.delete_health_report(health_report)

    {:noreply, assign(socket, :health_reports, list_health_reports())}
  end

  defp list_health_reports do
    HealthReports.list_health_reports()
  end
end

defmodule CoreaWeb.FinancialReportLive.Index do
  use CoreaWeb, :live_view

  alias Corea.FinancialReports
  alias Corea.FinancialReports.FinancialReport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :financial_reports, list_financial_reports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Financial report")
    |> assign(:financial_report, FinancialReports.get_financial_report!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Financial report")
    |> assign(:financial_report, %FinancialReport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Financial reports")
    |> assign(:financial_report, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    financial_report = FinancialReports.get_financial_report!(id)
    {:ok, _} = FinancialReports.delete_financial_report(financial_report)

    {:noreply, assign(socket, :financial_reports, list_financial_reports())}
  end

  defp list_financial_reports do
    FinancialReports.list_financial_reports()
  end
end

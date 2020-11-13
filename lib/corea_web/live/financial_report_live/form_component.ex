defmodule CoreaWeb.FinancialReportLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.FinancialReports

  @impl true
  def update(%{financial_report: financial_report} = assigns, socket) do
    changeset = FinancialReports.change_financial_report(financial_report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"financial_report" => financial_report_params}, socket) do
    changeset =
      socket.assigns.financial_report
      |> FinancialReports.change_financial_report(financial_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"financial_report" => financial_report_params}, socket) do
    save_financial_report(socket, socket.assigns.action, financial_report_params)
  end

  defp save_financial_report(socket, :edit, financial_report_params) do
    case FinancialReports.update_financial_report(socket.assigns.financial_report, financial_report_params) do
      {:ok, _financial_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Financial report updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_financial_report(socket, :new, financial_report_params) do
    case FinancialReports.create_financial_report(financial_report_params) do
      {:ok, _financial_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Financial report created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

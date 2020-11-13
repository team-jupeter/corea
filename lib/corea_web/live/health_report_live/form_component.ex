defmodule CoreaWeb.HealthReportLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.HealthReports

  @impl true
  def update(%{health_report: health_report} = assigns, socket) do
    changeset = HealthReports.change_health_report(health_report)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"health_report" => health_report_params}, socket) do
    changeset =
      socket.assigns.health_report
      |> HealthReports.change_health_report(health_report_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"health_report" => health_report_params}, socket) do
    save_health_report(socket, socket.assigns.action, health_report_params)
  end

  defp save_health_report(socket, :edit, health_report_params) do
    case HealthReports.update_health_report(socket.assigns.health_report, health_report_params) do
      {:ok, _health_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Health report updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_health_report(socket, :new, health_report_params) do
    case HealthReports.create_health_report(health_report_params) do
      {:ok, _health_report} ->
        {:noreply,
         socket
         |> put_flash(:info, "Health report created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

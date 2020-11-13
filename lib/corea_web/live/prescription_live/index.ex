defmodule CoreaWeb.PrescriptionLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Prescriptions
  alias Corea.Prescriptions.Prescription

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :prescriptions, list_prescriptions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Prescription")
    |> assign(:prescription, Prescriptions.get_prescription!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Prescription")
    |> assign(:prescription, %Prescription{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Prescriptions")
    |> assign(:prescription, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    prescription = Prescriptions.get_prescription!(id)
    {:ok, _} = Prescriptions.delete_prescription(prescription)

    {:noreply, assign(socket, :prescriptions, list_prescriptions())}
  end

  defp list_prescriptions do
    Prescriptions.list_prescriptions()
  end
end

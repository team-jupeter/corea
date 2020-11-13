defmodule CoreaWeb.PrescriptionLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Prescriptions

  @impl true
  def update(%{prescription: prescription} = assigns, socket) do
    changeset = Prescriptions.change_prescription(prescription)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"prescription" => prescription_params}, socket) do
    changeset =
      socket.assigns.prescription
      |> Prescriptions.change_prescription(prescription_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"prescription" => prescription_params}, socket) do
    save_prescription(socket, socket.assigns.action, prescription_params)
  end

  defp save_prescription(socket, :edit, prescription_params) do
    case Prescriptions.update_prescription(socket.assigns.prescription, prescription_params) do
      {:ok, _prescription} ->
        {:noreply,
         socket
         |> put_flash(:info, "Prescription updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_prescription(socket, :new, prescription_params) do
    case Prescriptions.create_prescription(prescription_params) do
      {:ok, _prescription} ->
        {:noreply,
         socket
         |> put_flash(:info, "Prescription created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

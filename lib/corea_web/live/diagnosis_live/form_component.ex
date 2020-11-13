defmodule CoreaWeb.DiagnosisLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Diagnoses

  @impl true
  def update(%{diagnosis: diagnosis} = assigns, socket) do
    changeset = Diagnoses.change_diagnosis(diagnosis)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"diagnosis" => diagnosis_params}, socket) do
    changeset =
      socket.assigns.diagnosis
      |> Diagnoses.change_diagnosis(diagnosis_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"diagnosis" => diagnosis_params}, socket) do
    save_diagnosis(socket, socket.assigns.action, diagnosis_params)
  end

  defp save_diagnosis(socket, :edit, diagnosis_params) do
    case Diagnoses.update_diagnosis(socket.assigns.diagnosis, diagnosis_params) do
      {:ok, _diagnosis} ->
        {:noreply,
         socket
         |> put_flash(:info, "Diagnosis updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_diagnosis(socket, :new, diagnosis_params) do
    case Diagnoses.create_diagnosis(diagnosis_params) do
      {:ok, _diagnosis} ->
        {:noreply,
         socket
         |> put_flash(:info, "Diagnosis created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

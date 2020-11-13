defmodule CoreaWeb.TreatmentLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Treatments

  @impl true
  def update(%{treatment: treatment} = assigns, socket) do
    changeset = Treatments.change_treatment(treatment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"treatment" => treatment_params}, socket) do
    changeset =
      socket.assigns.treatment
      |> Treatments.change_treatment(treatment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"treatment" => treatment_params}, socket) do
    save_treatment(socket, socket.assigns.action, treatment_params)
  end

  defp save_treatment(socket, :edit, treatment_params) do
    case Treatments.update_treatment(socket.assigns.treatment, treatment_params) do
      {:ok, _treatment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Treatment updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_treatment(socket, :new, treatment_params) do
    case Treatments.create_treatment(treatment_params) do
      {:ok, _treatment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Treatment created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

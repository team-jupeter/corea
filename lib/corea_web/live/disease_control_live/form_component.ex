defmodule CoreaWeb.DiseaseControlLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.DiseaseControls

  @impl true
  def update(%{disease_control: disease_control} = assigns, socket) do
    changeset = DiseaseControls.change_disease_control(disease_control)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"disease_control" => disease_control_params}, socket) do
    changeset =
      socket.assigns.disease_control
      |> DiseaseControls.change_disease_control(disease_control_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"disease_control" => disease_control_params}, socket) do
    save_disease_control(socket, socket.assigns.action, disease_control_params)
  end

  defp save_disease_control(socket, :edit, disease_control_params) do
    case DiseaseControls.update_disease_control(socket.assigns.disease_control, disease_control_params) do
      {:ok, _disease_control} ->
        {:noreply,
         socket
         |> put_flash(:info, "Disease control updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_disease_control(socket, :new, disease_control_params) do
    case DiseaseControls.create_disease_control(disease_control_params) do
      {:ok, _disease_control} ->
        {:noreply,
         socket
         |> put_flash(:info, "Disease control created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

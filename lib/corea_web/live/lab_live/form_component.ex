defmodule CoreaWeb.LabLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Labs

  @impl true
  def update(%{lab: lab} = assigns, socket) do
    changeset = Labs.change_lab(lab)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"lab" => lab_params}, socket) do
    changeset =
      socket.assigns.lab
      |> Labs.change_lab(lab_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"lab" => lab_params}, socket) do
    save_lab(socket, socket.assigns.action, lab_params)
  end

  defp save_lab(socket, :edit, lab_params) do
    case Labs.update_lab(socket.assigns.lab, lab_params) do
      {:ok, _lab} ->
        {:noreply,
         socket
         |> put_flash(:info, "Lab updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_lab(socket, :new, lab_params) do
    case Labs.create_lab(lab_params) do
      {:ok, _lab} ->
        {:noreply,
         socket
         |> put_flash(:info, "Lab created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

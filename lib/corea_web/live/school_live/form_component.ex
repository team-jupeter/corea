defmodule CoreaWeb.SchoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Schools

  @impl true
  def update(%{school: school} = assigns, socket) do
    changeset = Schools.change_school(school)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"school" => school_params}, socket) do
    changeset =
      socket.assigns.school
      |> Schools.change_school(school_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"school" => school_params}, socket) do
    save_school(socket, socket.assigns.action, school_params)
  end

  defp save_school(socket, :edit, school_params) do
    case Schools.update_school(socket.assigns.school, school_params) do
      {:ok, _school} ->
        {:noreply,
         socket
         |> put_flash(:info, "School updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_school(socket, :new, school_params) do
    case Schools.create_school(school_params) do
      {:ok, _school} ->
        {:noreply,
         socket
         |> put_flash(:info, "School created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

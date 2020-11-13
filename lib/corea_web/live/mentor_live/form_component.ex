defmodule CoreaWeb.MentorLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Mentors

  @impl true
  def update(%{mentor: mentor} = assigns, socket) do
    changeset = Mentors.change_mentor(mentor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"mentor" => mentor_params}, socket) do
    changeset =
      socket.assigns.mentor
      |> Mentors.change_mentor(mentor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"mentor" => mentor_params}, socket) do
    save_mentor(socket, socket.assigns.action, mentor_params)
  end

  defp save_mentor(socket, :edit, mentor_params) do
    case Mentors.update_mentor(socket.assigns.mentor, mentor_params) do
      {:ok, _mentor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mentor updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_mentor(socket, :new, mentor_params) do
    case Mentors.create_mentor(mentor_params) do
      {:ok, _mentor} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mentor created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

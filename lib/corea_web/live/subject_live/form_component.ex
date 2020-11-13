defmodule CoreaWeb.SubjectLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Subjects

  @impl true
  def update(%{subject: subject} = assigns, socket) do
    changeset = Subjects.change_subject(subject)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"subject" => subject_params}, socket) do
    changeset =
      socket.assigns.subject
      |> Subjects.change_subject(subject_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"subject" => subject_params}, socket) do
    save_subject(socket, socket.assigns.action, subject_params)
  end

  defp save_subject(socket, :edit, subject_params) do
    case Subjects.update_subject(socket.assigns.subject, subject_params) do
      {:ok, _subject} ->
        {:noreply,
         socket
         |> put_flash(:info, "Subject updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_subject(socket, :new, subject_params) do
    case Subjects.create_subject(subject_params) do
      {:ok, _subject} ->
        {:noreply,
         socket
         |> put_flash(:info, "Subject created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

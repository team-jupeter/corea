defmodule CoreaWeb.PayloadArchiveLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.PayloadArchives

  @impl true
  def update(%{payload_archive: payload_archive} = assigns, socket) do
    changeset = PayloadArchives.change_payload_archive(payload_archive)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"payload_archive" => payload_archive_params}, socket) do
    changeset =
      socket.assigns.payload_archive
      |> PayloadArchives.change_payload_archive(payload_archive_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"payload_archive" => payload_archive_params}, socket) do
    save_payload_archive(socket, socket.assigns.action, payload_archive_params)
  end

  defp save_payload_archive(socket, :edit, payload_archive_params) do
    case PayloadArchives.update_payload_archive(socket.assigns.payload_archive, payload_archive_params) do
      {:ok, _payload_archive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payload archive updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_payload_archive(socket, :new, payload_archive_params) do
    case PayloadArchives.create_payload_archive(payload_archive_params) do
      {:ok, _payload_archive} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payload archive created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

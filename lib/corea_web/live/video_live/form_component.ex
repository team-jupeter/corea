defmodule CoreaWeb.VideoLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Videos

  @impl true
  def update(%{video: video} = assigns, socket) do
    changeset = Videos.change_video(video)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"video" => video_params}, socket) do
    changeset =
      socket.assigns.video
      |> Videos.change_video(video_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"video" => video_params}, socket) do
    save_video(socket, socket.assigns.action, video_params)
  end

  defp save_video(socket, :edit, video_params) do
    case Videos.update_video(socket.assigns.video, video_params) do
      {:ok, _video} ->
        {:noreply,
         socket
         |> put_flash(:info, "Video updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_video(socket, :new, video_params) do
    case Videos.create_video(video_params) do
      {:ok, _video} ->
        {:noreply,
         socket
         |> put_flash(:info, "Video created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.WeddingLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Weddings

  @impl true
  def update(%{wedding: wedding} = assigns, socket) do
    changeset = Weddings.change_wedding(wedding)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"wedding" => wedding_params}, socket) do
    changeset =
      socket.assigns.wedding
      |> Weddings.change_wedding(wedding_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"wedding" => wedding_params}, socket) do
    save_wedding(socket, socket.assigns.action, wedding_params)
  end

  defp save_wedding(socket, :edit, wedding_params) do
    case Weddings.update_wedding(socket.assigns.wedding, wedding_params) do
      {:ok, _wedding} ->
        {:noreply,
         socket
         |> put_flash(:info, "Wedding updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_wedding(socket, :new, wedding_params) do
    case Weddings.create_wedding(wedding_params) do
      {:ok, _wedding} ->
        {:noreply,
         socket
         |> put_flash(:info, "Wedding created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

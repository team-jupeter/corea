defmodule CoreaWeb.PoliceLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Polices

  @impl true
  def update(%{police: police} = assigns, socket) do
    changeset = Polices.change_police(police)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"police" => police_params}, socket) do
    changeset =
      socket.assigns.police
      |> Polices.change_police(police_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"police" => police_params}, socket) do
    save_police(socket, socket.assigns.action, police_params)
  end

  defp save_police(socket, :edit, police_params) do
    case Polices.update_police(socket.assigns.police, police_params) do
      {:ok, _police} ->
        {:noreply,
         socket
         |> put_flash(:info, "Police updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_police(socket, :new, police_params) do
    case Polices.create_police(police_params) do
      {:ok, _police} ->
        {:noreply,
         socket
         |> put_flash(:info, "Police created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

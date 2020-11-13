defmodule CoreaWeb.T4Live.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T4s

  @impl true
  def update(%{t4: t4} = assigns, socket) do
    changeset = T4s.change_t4(t4)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t4" => t4_params}, socket) do
    changeset =
      socket.assigns.t4
      |> T4s.change_t4(t4_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t4" => t4_params}, socket) do
    save_t4(socket, socket.assigns.action, t4_params)
  end

  defp save_t4(socket, :edit, t4_params) do
    case T4s.update_t4(socket.assigns.t4, t4_params) do
      {:ok, _t4} ->
        {:noreply,
         socket
         |> put_flash(:info, "T4 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t4(socket, :new, t4_params) do
    case T4s.create_t4(t4_params) do
      {:ok, _t4} ->
        {:noreply,
         socket
         |> put_flash(:info, "T4 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.T2Live.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T2s

  @impl true
  def update(%{t2: t2} = assigns, socket) do
    changeset = T2s.change_t2(t2)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t2" => t2_params}, socket) do
    changeset =
      socket.assigns.t2
      |> T2s.change_t2(t2_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t2" => t2_params}, socket) do
    save_t2(socket, socket.assigns.action, t2_params)
  end

  defp save_t2(socket, :edit, t2_params) do
    case T2s.update_t2(socket.assigns.t2, t2_params) do
      {:ok, _t2} ->
        {:noreply,
         socket
         |> put_flash(:info, "T2 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t2(socket, :new, t2_params) do
    case T2s.create_t2(t2_params) do
      {:ok, _t2} ->
        {:noreply,
         socket
         |> put_flash(:info, "T2 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

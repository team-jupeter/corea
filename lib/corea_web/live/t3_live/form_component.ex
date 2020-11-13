defmodule CoreaWeb.T3Live.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T3s

  @impl true
  def update(%{t3: t3} = assigns, socket) do
    changeset = T3s.change_t3(t3)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t3" => t3_params}, socket) do
    changeset =
      socket.assigns.t3
      |> T3s.change_t3(t3_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t3" => t3_params}, socket) do
    save_t3(socket, socket.assigns.action, t3_params)
  end

  defp save_t3(socket, :edit, t3_params) do
    case T3s.update_t3(socket.assigns.t3, t3_params) do
      {:ok, _t3} ->
        {:noreply,
         socket
         |> put_flash(:info, "T3 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t3(socket, :new, t3_params) do
    case T3s.create_t3(t3_params) do
      {:ok, _t3} ->
        {:noreply,
         socket
         |> put_flash(:info, "T3 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.T5Live.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T5s

  @impl true
  def update(%{t5: t5} = assigns, socket) do
    changeset = T5s.change_t5(t5)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t5" => t5_params}, socket) do
    changeset =
      socket.assigns.t5
      |> T5s.change_t5(t5_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t5" => t5_params}, socket) do
    save_t5(socket, socket.assigns.action, t5_params)
  end

  defp save_t5(socket, :edit, t5_params) do
    case T5s.update_t5(socket.assigns.t5, t5_params) do
      {:ok, _t5} ->
        {:noreply,
         socket
         |> put_flash(:info, "T5 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t5(socket, :new, t5_params) do
    case T5s.create_t5(t5_params) do
      {:ok, _t5} ->
        {:noreply,
         socket
         |> put_flash(:info, "T5 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

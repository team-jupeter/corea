defmodule CoreaWeb.T1Live.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T1s

  @impl true
  def update(%{t1: t1} = assigns, socket) do
    changeset = T1s.change_t1(t1)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t1" => t1_params}, socket) do
    changeset =
      socket.assigns.t1
      |> T1s.change_t1(t1_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t1" => t1_params}, socket) do
    save_t1(socket, socket.assigns.action, t1_params)
  end

  defp save_t1(socket, :edit, t1_params) do
    case T1s.update_t1(socket.assigns.t1, t1_params) do
      {:ok, _t1} ->
        {:noreply,
         socket
         |> put_flash(:info, "T1 updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t1(socket, :new, t1_params) do
    case T1s.create_t1(t1_params) do
      {:ok, _t1} ->
        {:noreply,
         socket
         |> put_flash(:info, "T1 created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

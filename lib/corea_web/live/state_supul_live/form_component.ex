defmodule CoreaWeb.StateSupulLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.StateSupuls

  @impl true
  def update(%{state_supul: state_supul} = assigns, socket) do
    changeset = StateSupuls.change_state_supul(state_supul)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"state_supul" => state_supul_params}, socket) do
    changeset =
      socket.assigns.state_supul
      |> StateSupuls.change_state_supul(state_supul_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"state_supul" => state_supul_params}, socket) do
    save_state_supul(socket, socket.assigns.action, state_supul_params)
  end

  defp save_state_supul(socket, :edit, state_supul_params) do
    case StateSupuls.update_state_supul(socket.assigns.state_supul, state_supul_params) do
      {:ok, _state_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "State supul updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_state_supul(socket, :new, state_supul_params) do
    case StateSupuls.create_state_supul(state_supul_params) do
      {:ok, _state_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "State supul created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

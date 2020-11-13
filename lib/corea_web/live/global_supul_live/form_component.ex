defmodule CoreaWeb.GlobalSupulLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GlobalSupuls

  @impl true
  def update(%{global_supul: global_supul} = assigns, socket) do
    changeset = GlobalSupuls.change_global_supul(global_supul)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"global_supul" => global_supul_params}, socket) do
    changeset =
      socket.assigns.global_supul
      |> GlobalSupuls.change_global_supul(global_supul_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"global_supul" => global_supul_params}, socket) do
    save_global_supul(socket, socket.assigns.action, global_supul_params)
  end

  defp save_global_supul(socket, :edit, global_supul_params) do
    case GlobalSupuls.update_global_supul(socket.assigns.global_supul, global_supul_params) do
      {:ok, _global_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Global supul updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_global_supul(socket, :new, global_supul_params) do
    case GlobalSupuls.create_global_supul(global_supul_params) do
      {:ok, _global_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Global supul created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.SupulLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Supuls

  @impl true
  def update(%{supul: supul} = assigns, socket) do
    changeset = Supuls.change_supul(supul)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"supul" => supul_params}, socket) do
    changeset =
      socket.assigns.supul
      |> Supuls.change_supul(supul_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"supul" => supul_params}, socket) do
    save_supul(socket, socket.assigns.action, supul_params)
  end

  defp save_supul(socket, :edit, supul_params) do
    case Supuls.update_supul(socket.assigns.supul, supul_params) do
      {:ok, _supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supul updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_supul(socket, :new, supul_params) do
    case Supuls.create_supul(supul_params) do
      {:ok, _supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supul created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

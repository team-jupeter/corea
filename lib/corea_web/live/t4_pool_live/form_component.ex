defmodule CoreaWeb.T4PoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T4Pools

  @impl true
  def update(%{t4_pool: t4_pool} = assigns, socket) do
    changeset = T4Pools.change_t4_pool(t4_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t4_pool" => t4_pool_params}, socket) do
    changeset =
      socket.assigns.t4_pool
      |> T4Pools.change_t4_pool(t4_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t4_pool" => t4_pool_params}, socket) do
    save_t4_pool(socket, socket.assigns.action, t4_pool_params)
  end

  defp save_t4_pool(socket, :edit, t4_pool_params) do
    case T4Pools.update_t4_pool(socket.assigns.t4_pool, t4_pool_params) do
      {:ok, _t4_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T4 pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t4_pool(socket, :new, t4_pool_params) do
    case T4Pools.create_t4_pool(t4_pool_params) do
      {:ok, _t4_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T4 pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

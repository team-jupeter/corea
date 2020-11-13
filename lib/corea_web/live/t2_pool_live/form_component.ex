defmodule CoreaWeb.T2PoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T2Pools

  @impl true
  def update(%{t2_pool: t2_pool} = assigns, socket) do
    changeset = T2Pools.change_t2_pool(t2_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t2_pool" => t2_pool_params}, socket) do
    changeset =
      socket.assigns.t2_pool
      |> T2Pools.change_t2_pool(t2_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t2_pool" => t2_pool_params}, socket) do
    save_t2_pool(socket, socket.assigns.action, t2_pool_params)
  end

  defp save_t2_pool(socket, :edit, t2_pool_params) do
    case T2Pools.update_t2_pool(socket.assigns.t2_pool, t2_pool_params) do
      {:ok, _t2_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T2 pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t2_pool(socket, :new, t2_pool_params) do
    case T2Pools.create_t2_pool(t2_pool_params) do
      {:ok, _t2_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T2 pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

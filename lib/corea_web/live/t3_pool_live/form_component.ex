defmodule CoreaWeb.T3PoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T3Pools

  @impl true
  def update(%{t3_pool: t3_pool} = assigns, socket) do
    changeset = T3Pools.change_t3_pool(t3_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t3_pool" => t3_pool_params}, socket) do
    changeset =
      socket.assigns.t3_pool
      |> T3Pools.change_t3_pool(t3_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t3_pool" => t3_pool_params}, socket) do
    save_t3_pool(socket, socket.assigns.action, t3_pool_params)
  end

  defp save_t3_pool(socket, :edit, t3_pool_params) do
    case T3Pools.update_t3_pool(socket.assigns.t3_pool, t3_pool_params) do
      {:ok, _t3_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T3 pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t3_pool(socket, :new, t3_pool_params) do
    case T3Pools.create_t3_pool(t3_pool_params) do
      {:ok, _t3_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T3 pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

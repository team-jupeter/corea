defmodule CoreaWeb.T1PoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.T1Pools

  @impl true
  def update(%{t1_pool: t1_pool} = assigns, socket) do
    changeset = T1Pools.change_t1_pool(t1_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"t1_pool" => t1_pool_params}, socket) do
    changeset =
      socket.assigns.t1_pool
      |> T1Pools.change_t1_pool(t1_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"t1_pool" => t1_pool_params}, socket) do
    save_t1_pool(socket, socket.assigns.action, t1_pool_params)
  end

  defp save_t1_pool(socket, :edit, t1_pool_params) do
    case T1Pools.update_t1_pool(socket.assigns.t1_pool, t1_pool_params) do
      {:ok, _t1_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T1 pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_t1_pool(socket, :new, t1_pool_params) do
    case T1Pools.create_t1_pool(t1_pool_params) do
      {:ok, _t1_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "T1 pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

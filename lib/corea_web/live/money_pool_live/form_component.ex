defmodule CoreaWeb.MoneyPoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.MoneyPools

  @impl true
  def update(%{money_pool: money_pool} = assigns, socket) do
    changeset = MoneyPools.change_money_pool(money_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"money_pool" => money_pool_params}, socket) do
    changeset =
      socket.assigns.money_pool
      |> MoneyPools.change_money_pool(money_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"money_pool" => money_pool_params}, socket) do
    save_money_pool(socket, socket.assigns.action, money_pool_params)
  end

  defp save_money_pool(socket, :edit, money_pool_params) do
    case MoneyPools.update_money_pool(socket.assigns.money_pool, money_pool_params) do
      {:ok, _money_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "Money pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_money_pool(socket, :new, money_pool_params) do
    case MoneyPools.create_money_pool(money_pool_params) do
      {:ok, _money_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "Money pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

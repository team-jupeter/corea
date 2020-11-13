defmodule CoreaWeb.FiatPoolLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.FiatPools

  @impl true
  def update(%{fiat_pool: fiat_pool} = assigns, socket) do
    changeset = FiatPools.change_fiat_pool(fiat_pool)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"fiat_pool" => fiat_pool_params}, socket) do
    changeset =
      socket.assigns.fiat_pool
      |> FiatPools.change_fiat_pool(fiat_pool_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"fiat_pool" => fiat_pool_params}, socket) do
    save_fiat_pool(socket, socket.assigns.action, fiat_pool_params)
  end

  defp save_fiat_pool(socket, :edit, fiat_pool_params) do
    case FiatPools.update_fiat_pool(socket.assigns.fiat_pool, fiat_pool_params) do
      {:ok, _fiat_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fiat pool updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_fiat_pool(socket, :new, fiat_pool_params) do
    case FiatPools.create_fiat_pool(fiat_pool_params) do
      {:ok, _fiat_pool} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fiat pool created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

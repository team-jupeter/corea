defmodule CoreaWeb.DepositLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Deposits

  @impl true
  def update(%{deposit: deposit} = assigns, socket) do
    changeset = Deposits.change_deposit(deposit)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"deposit" => deposit_params}, socket) do
    changeset =
      socket.assigns.deposit
      |> Deposits.change_deposit(deposit_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"deposit" => deposit_params}, socket) do
    save_deposit(socket, socket.assigns.action, deposit_params)
  end

  defp save_deposit(socket, :edit, deposit_params) do
    case Deposits.update_deposit(socket.assigns.deposit, deposit_params) do
      {:ok, _deposit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deposit updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_deposit(socket, :new, deposit_params) do
    case Deposits.create_deposit(deposit_params) do
      {:ok, _deposit} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deposit created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

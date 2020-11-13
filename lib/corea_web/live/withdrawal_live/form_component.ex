defmodule CoreaWeb.WithdrawalLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Withdrawals

  @impl true
  def update(%{withdrawal: withdrawal} = assigns, socket) do
    changeset = Withdrawals.change_withdrawal(withdrawal)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"withdrawal" => withdrawal_params}, socket) do
    changeset =
      socket.assigns.withdrawal
      |> Withdrawals.change_withdrawal(withdrawal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"withdrawal" => withdrawal_params}, socket) do
    save_withdrawal(socket, socket.assigns.action, withdrawal_params)
  end

  defp save_withdrawal(socket, :edit, withdrawal_params) do
    case Withdrawals.update_withdrawal(socket.assigns.withdrawal, withdrawal_params) do
      {:ok, _withdrawal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Withdrawal updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_withdrawal(socket, :new, withdrawal_params) do
    case Withdrawals.create_withdrawal(withdrawal_params) do
      {:ok, _withdrawal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Withdrawal created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.FinancialAccountLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.FinancialAccounts

  @impl true
  def update(%{financial_account: financial_account} = assigns, socket) do
    changeset = FinancialAccounts.change_financial_account(financial_account)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"financial_account" => financial_account_params}, socket) do
    changeset =
      socket.assigns.financial_account
      |> FinancialAccounts.change_financial_account(financial_account_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"financial_account" => financial_account_params}, socket) do
    save_financial_account(socket, socket.assigns.action, financial_account_params)
  end

  defp save_financial_account(socket, :edit, financial_account_params) do
    case FinancialAccounts.update_financial_account(socket.assigns.financial_account, financial_account_params) do
      {:ok, _financial_account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Financial account updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_financial_account(socket, :new, financial_account_params) do
    case FinancialAccounts.create_financial_account(financial_account_params) do
      {:ok, _financial_account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Financial account created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

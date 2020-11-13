defmodule CoreaWeb.BalanceSheetLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.BalanceSheets

  @impl true
  def update(%{balance_sheet: balance_sheet} = assigns, socket) do
    changeset = BalanceSheets.change_balance_sheet(balance_sheet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"balance_sheet" => balance_sheet_params}, socket) do
    changeset =
      socket.assigns.balance_sheet
      |> BalanceSheets.change_balance_sheet(balance_sheet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"balance_sheet" => balance_sheet_params}, socket) do
    save_balance_sheet(socket, socket.assigns.action, balance_sheet_params)
  end

  defp save_balance_sheet(socket, :edit, balance_sheet_params) do
    case BalanceSheets.update_balance_sheet(socket.assigns.balance_sheet, balance_sheet_params) do
      {:ok, _balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Balance sheet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_balance_sheet(socket, :new, balance_sheet_params) do
    case BalanceSheets.create_balance_sheet(balance_sheet_params) do
      {:ok, _balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Balance sheet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

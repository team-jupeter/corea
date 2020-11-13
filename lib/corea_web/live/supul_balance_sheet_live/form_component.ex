defmodule CoreaWeb.SupulBalanceSheetLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.SupulBalanceSheets

  @impl true
  def update(%{supul_balance_sheet: supul_balance_sheet} = assigns, socket) do
    changeset = SupulBalanceSheets.change_supul_balance_sheet(supul_balance_sheet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"supul_balance_sheet" => supul_balance_sheet_params}, socket) do
    changeset =
      socket.assigns.supul_balance_sheet
      |> SupulBalanceSheets.change_supul_balance_sheet(supul_balance_sheet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"supul_balance_sheet" => supul_balance_sheet_params}, socket) do
    save_supul_balance_sheet(socket, socket.assigns.action, supul_balance_sheet_params)
  end

  defp save_supul_balance_sheet(socket, :edit, supul_balance_sheet_params) do
    case SupulBalanceSheets.update_supul_balance_sheet(socket.assigns.supul_balance_sheet, supul_balance_sheet_params) do
      {:ok, _supul_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supul balance sheet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_supul_balance_sheet(socket, :new, supul_balance_sheet_params) do
    case SupulBalanceSheets.create_supul_balance_sheet(supul_balance_sheet_params) do
      {:ok, _supul_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Supul balance sheet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

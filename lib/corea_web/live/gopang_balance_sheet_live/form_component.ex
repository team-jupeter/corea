defmodule CoreaWeb.GopangBalanceSheetLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GopangBalanceSheets

  @impl true
  def update(%{gopang_balance_sheet: gopang_balance_sheet} = assigns, socket) do
    changeset = GopangBalanceSheets.change_gopang_balance_sheet(gopang_balance_sheet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gopang_balance_sheet" => gopang_balance_sheet_params}, socket) do
    changeset =
      socket.assigns.gopang_balance_sheet
      |> GopangBalanceSheets.change_gopang_balance_sheet(gopang_balance_sheet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gopang_balance_sheet" => gopang_balance_sheet_params}, socket) do
    save_gopang_balance_sheet(socket, socket.assigns.action, gopang_balance_sheet_params)
  end

  defp save_gopang_balance_sheet(socket, :edit, gopang_balance_sheet_params) do
    case GopangBalanceSheets.update_gopang_balance_sheet(socket.assigns.gopang_balance_sheet, gopang_balance_sheet_params) do
      {:ok, _gopang_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gopang balance sheet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gopang_balance_sheet(socket, :new, gopang_balance_sheet_params) do
    case GopangBalanceSheets.create_gopang_balance_sheet(gopang_balance_sheet_params) do
      {:ok, _gopang_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gopang balance sheet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

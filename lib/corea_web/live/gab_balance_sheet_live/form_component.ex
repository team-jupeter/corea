defmodule CoreaWeb.GABBalanceSheetLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GABBalanceSheets

  @impl true
  def update(%{gab_balance_sheet: gab_balance_sheet} = assigns, socket) do
    changeset = GABBalanceSheets.change_gab_balance_sheet(gab_balance_sheet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gab_balance_sheet" => gab_balance_sheet_params}, socket) do
    changeset =
      socket.assigns.gab_balance_sheet
      |> GABBalanceSheets.change_gab_balance_sheet(gab_balance_sheet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gab_balance_sheet" => gab_balance_sheet_params}, socket) do
    save_gab_balance_sheet(socket, socket.assigns.action, gab_balance_sheet_params)
  end

  defp save_gab_balance_sheet(socket, :edit, gab_balance_sheet_params) do
    case GABBalanceSheets.update_gab_balance_sheet(socket.assigns.gab_balance_sheet, gab_balance_sheet_params) do
      {:ok, _gab_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab balance sheet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gab_balance_sheet(socket, :new, gab_balance_sheet_params) do
    case GABBalanceSheets.create_gab_balance_sheet(gab_balance_sheet_params) do
      {:ok, _gab_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab balance sheet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

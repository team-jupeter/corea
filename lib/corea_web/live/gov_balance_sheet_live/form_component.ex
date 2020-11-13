defmodule CoreaWeb.GovBalanceSheetLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GovBalanceSheets

  @impl true
  def update(%{gov_balance_sheet: gov_balance_sheet} = assigns, socket) do
    changeset = GovBalanceSheets.change_gov_balance_sheet(gov_balance_sheet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gov_balance_sheet" => gov_balance_sheet_params}, socket) do
    changeset =
      socket.assigns.gov_balance_sheet
      |> GovBalanceSheets.change_gov_balance_sheet(gov_balance_sheet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gov_balance_sheet" => gov_balance_sheet_params}, socket) do
    save_gov_balance_sheet(socket, socket.assigns.action, gov_balance_sheet_params)
  end

  defp save_gov_balance_sheet(socket, :edit, gov_balance_sheet_params) do
    case GovBalanceSheets.update_gov_balance_sheet(socket.assigns.gov_balance_sheet, gov_balance_sheet_params) do
      {:ok, _gov_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gov balance sheet updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gov_balance_sheet(socket, :new, gov_balance_sheet_params) do
    case GovBalanceSheets.create_gov_balance_sheet(gov_balance_sheet_params) do
      {:ok, _gov_balance_sheet} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gov balance sheet created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

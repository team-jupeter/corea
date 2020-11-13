defmodule CoreaWeb.GABAccountLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GABAccounts

  @impl true
  def update(%{gab_account: gab_account} = assigns, socket) do
    changeset = GABAccounts.change_gab_account(gab_account)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gab_account" => gab_account_params}, socket) do
    changeset =
      socket.assigns.gab_account
      |> GABAccounts.change_gab_account(gab_account_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gab_account" => gab_account_params}, socket) do
    save_gab_account(socket, socket.assigns.action, gab_account_params)
  end

  defp save_gab_account(socket, :edit, gab_account_params) do
    case GABAccounts.update_gab_account(socket.assigns.gab_account, gab_account_params) do
      {:ok, _gab_account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab account updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gab_account(socket, :new, gab_account_params) do
    case GABAccounts.create_gab_account(gab_account_params) do
      {:ok, _gab_account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab account created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.AccountBookLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.AccountBooks

  @impl true
  def update(%{account_book: account_book} = assigns, socket) do
    changeset = AccountBooks.change_account_book(account_book)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"account_book" => account_book_params}, socket) do
    changeset =
      socket.assigns.account_book
      |> AccountBooks.change_account_book(account_book_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"account_book" => account_book_params}, socket) do
    save_account_book(socket, socket.assigns.action, account_book_params)
  end

  defp save_account_book(socket, :edit, account_book_params) do
    case AccountBooks.update_account_book(socket.assigns.account_book, account_book_params) do
      {:ok, _account_book} ->
        {:noreply,
         socket
         |> put_flash(:info, "Account book updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_account_book(socket, :new, account_book_params) do
    case AccountBooks.create_account_book(account_book_params) do
      {:ok, _account_book} ->
        {:noreply,
         socket
         |> put_flash(:info, "Account book created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

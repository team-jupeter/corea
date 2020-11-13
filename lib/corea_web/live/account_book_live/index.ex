defmodule CoreaWeb.AccountBookLive.Index do
  use CoreaWeb, :live_view

  alias Corea.AccountBooks
  alias Corea.AccountBooks.AccountBook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :account_books, list_account_books())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Account book")
    |> assign(:account_book, AccountBooks.get_account_book!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account book")
    |> assign(:account_book, %AccountBook{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Account books")
    |> assign(:account_book, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    account_book = AccountBooks.get_account_book!(id)
    {:ok, _} = AccountBooks.delete_account_book(account_book)

    {:noreply, assign(socket, :account_books, list_account_books())}
  end

  defp list_account_books do
    AccountBooks.list_account_books()
  end
end

defmodule CoreaWeb.AccountBookLive.Show do
  use CoreaWeb, :live_view

  alias Corea.AccountBooks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:account_book, AccountBooks.get_account_book!(id))}
  end

  defp page_title(:show), do: "Show Account book"
  defp page_title(:edit), do: "Edit Account book"
end

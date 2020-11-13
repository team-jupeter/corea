defmodule CoreaWeb.TerminalLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Terminals
  alias Corea.Terminals.Terminal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :terminals, list_terminals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Terminal")
    |> assign(:terminal, Terminals.get_terminal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Terminal")
    |> assign(:terminal, %Terminal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Terminals")
    |> assign(:terminal, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    terminal = Terminals.get_terminal!(id)
    {:ok, _} = Terminals.delete_terminal(terminal)

    {:noreply, assign(socket, :terminals, list_terminals())}
  end

  defp list_terminals do
    Terminals.list_terminals()
  end
end

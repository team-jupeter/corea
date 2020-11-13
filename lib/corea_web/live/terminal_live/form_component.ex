defmodule CoreaWeb.TerminalLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Terminals

  @impl true
  def update(%{terminal: terminal} = assigns, socket) do
    changeset = Terminals.change_terminal(terminal)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"terminal" => terminal_params}, socket) do
    changeset =
      socket.assigns.terminal
      |> Terminals.change_terminal(terminal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"terminal" => terminal_params}, socket) do
    save_terminal(socket, socket.assigns.action, terminal_params)
  end

  defp save_terminal(socket, :edit, terminal_params) do
    case Terminals.update_terminal(socket.assigns.terminal, terminal_params) do
      {:ok, _terminal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Terminal updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_terminal(socket, :new, terminal_params) do
    case Terminals.create_terminal(terminal_params) do
      {:ok, _terminal} ->
        {:noreply,
         socket
         |> put_flash(:info, "Terminal created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

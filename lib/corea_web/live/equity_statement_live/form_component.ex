defmodule CoreaWeb.EquityStatementLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.EquityStatements

  @impl true
  def update(%{equity_statement: equity_statement} = assigns, socket) do
    changeset = EquityStatements.change_equity_statement(equity_statement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"equity_statement" => equity_statement_params}, socket) do
    changeset =
      socket.assigns.equity_statement
      |> EquityStatements.change_equity_statement(equity_statement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"equity_statement" => equity_statement_params}, socket) do
    save_equity_statement(socket, socket.assigns.action, equity_statement_params)
  end

  defp save_equity_statement(socket, :edit, equity_statement_params) do
    case EquityStatements.update_equity_statement(socket.assigns.equity_statement, equity_statement_params) do
      {:ok, _equity_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Equity statement updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_equity_statement(socket, :new, equity_statement_params) do
    case EquityStatements.create_equity_statement(equity_statement_params) do
      {:ok, _equity_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Equity statement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

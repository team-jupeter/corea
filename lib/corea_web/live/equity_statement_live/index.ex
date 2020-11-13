defmodule CoreaWeb.EquityStatementLive.Index do
  use CoreaWeb, :live_view

  alias Corea.EquityStatements
  alias Corea.EquityStatements.EquityStatement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :equity_statements, list_equity_statements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Equity statement")
    |> assign(:equity_statement, EquityStatements.get_equity_statement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Equity statement")
    |> assign(:equity_statement, %EquityStatement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Equity statements")
    |> assign(:equity_statement, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    equity_statement = EquityStatements.get_equity_statement!(id)
    {:ok, _} = EquityStatements.delete_equity_statement(equity_statement)

    {:noreply, assign(socket, :equity_statements, list_equity_statements())}
  end

  defp list_equity_statements do
    EquityStatements.list_equity_statements()
  end
end

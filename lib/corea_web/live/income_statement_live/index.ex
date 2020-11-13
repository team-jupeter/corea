defmodule CoreaWeb.IncomeStatementLive.Index do
  use CoreaWeb, :live_view

  alias Corea.IncomeStatements
  alias Corea.IncomeStatements.IncomeStatement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :income_statements, list_income_statements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Income statement")
    |> assign(:income_statement, IncomeStatements.get_income_statement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Income statement")
    |> assign(:income_statement, %IncomeStatement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Income statements")
    |> assign(:income_statement, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    income_statement = IncomeStatements.get_income_statement!(id)
    {:ok, _} = IncomeStatements.delete_income_statement(income_statement)

    {:noreply, assign(socket, :income_statements, list_income_statements())}
  end

  defp list_income_statements do
    IncomeStatements.list_income_statements()
  end
end

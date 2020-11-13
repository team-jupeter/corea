defmodule CoreaWeb.CFStatementLive.Index do
  use CoreaWeb, :live_view

  alias Corea.CFStatements
  alias Corea.CFStatements.CFStatement

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cf_statements, list_cf_statements())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cf statement")
    |> assign(:cf_statement, CFStatements.get_cf_statement!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cf statement")
    |> assign(:cf_statement, %CFStatement{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cf statements")
    |> assign(:cf_statement, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cf_statement = CFStatements.get_cf_statement!(id)
    {:ok, _} = CFStatements.delete_cf_statement(cf_statement)

    {:noreply, assign(socket, :cf_statements, list_cf_statements())}
  end

  defp list_cf_statements do
    CFStatements.list_cf_statements()
  end
end

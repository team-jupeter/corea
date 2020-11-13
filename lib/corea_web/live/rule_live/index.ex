defmodule CoreaWeb.RuleLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Rules
  alias Corea.Rules.Rule

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :rules, list_rules())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rule")
    |> assign(:rule, Rules.get_rule!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rule")
    |> assign(:rule, %Rule{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rules")
    |> assign(:rule, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rule = Rules.get_rule!(id)
    {:ok, _} = Rules.delete_rule(rule)

    {:noreply, assign(socket, :rules, list_rules())}
  end

  defp list_rules do
    Rules.list_rules()
  end
end

defmodule CoreaWeb.OrdinanceLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Ordinances
  alias Corea.Ordinances.Ordinance

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ordinances, list_ordinances())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ordinance")
    |> assign(:ordinance, Ordinances.get_ordinance!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ordinance")
    |> assign(:ordinance, %Ordinance{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ordinances")
    |> assign(:ordinance, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ordinance = Ordinances.get_ordinance!(id)
    {:ok, _} = Ordinances.delete_ordinance(ordinance)

    {:noreply, assign(socket, :ordinances, list_ordinances())}
  end

  defp list_ordinances do
    Ordinances.list_ordinances()
  end
end

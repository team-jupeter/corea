defmodule CoreaWeb.TaxationLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Taxations
  alias Corea.Taxations.Taxation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :taxations, list_taxations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Taxation")
    |> assign(:taxation, Taxations.get_taxation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Taxation")
    |> assign(:taxation, %Taxation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Taxations")
    |> assign(:taxation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    taxation = Taxations.get_taxation!(id)
    {:ok, _} = Taxations.delete_taxation(taxation)

    {:noreply, assign(socket, :taxations, list_taxations())}
  end

  defp list_taxations do
    Taxations.list_taxations()
  end
end

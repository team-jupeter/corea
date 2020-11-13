defmodule CoreaWeb.RealEstateLive.Index do
  use CoreaWeb, :live_view

  alias Corea.RealEstates
  alias Corea.RealEstates.RealEstate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :real_estates, list_real_estates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Real estate")
    |> assign(:real_estate, RealEstates.get_real_estate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Real estate")
    |> assign(:real_estate, %RealEstate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Real estates")
    |> assign(:real_estate, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    real_estate = RealEstates.get_real_estate!(id)
    {:ok, _} = RealEstates.delete_real_estate(real_estate)

    {:noreply, assign(socket, :real_estates, list_real_estates())}
  end

  defp list_real_estates do
    RealEstates.list_real_estates()
  end
end

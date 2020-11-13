defmodule CoreaWeb.BioDatumLive.Index do
  use CoreaWeb, :live_view

  alias Corea.BioData
  alias Corea.BioData.BioDatum

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bio_data, list_bio_data())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bio datum")
    |> assign(:bio_datum, BioData.get_bio_datum!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bio datum")
    |> assign(:bio_datum, %BioDatum{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bio data")
    |> assign(:bio_datum, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bio_datum = BioData.get_bio_datum!(id)
    {:ok, _} = BioData.delete_bio_datum(bio_datum)

    {:noreply, assign(socket, :bio_data, list_bio_data())}
  end

  defp list_bio_data do
    BioData.list_bio_data()
  end
end

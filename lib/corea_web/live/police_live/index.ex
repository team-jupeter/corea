defmodule CoreaWeb.PoliceLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Polices
  alias Corea.Polices.Police

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :polices, list_polices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Police")
    |> assign(:police, Polices.get_police!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Police")
    |> assign(:police, %Police{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Polices")
    |> assign(:police, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    police = Polices.get_police!(id)
    {:ok, _} = Polices.delete_police(police)

    {:noreply, assign(socket, :polices, list_polices())}
  end

  defp list_polices do
    Polices.list_polices()
  end
end

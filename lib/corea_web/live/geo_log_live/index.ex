defmodule CoreaWeb.GeoLogLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GeoLogs
  alias Corea.GeoLogs.GeoLog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :geo_logs, list_geo_logs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Geo log")
    |> assign(:geo_log, GeoLogs.get_geo_log!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Geo log")
    |> assign(:geo_log, %GeoLog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Geo logs")
    |> assign(:geo_log, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    geo_log = GeoLogs.get_geo_log!(id)
    {:ok, _} = GeoLogs.delete_geo_log(geo_log)

    {:noreply, assign(socket, :geo_logs, list_geo_logs())}
  end

  defp list_geo_logs do
    GeoLogs.list_geo_logs()
  end
end

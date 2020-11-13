defmodule CoreaWeb.PayloadArchiveLive.Index do
  use CoreaWeb, :live_view

  alias Corea.PayloadArchives
  alias Corea.PayloadArchives.PayloadArchive

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :payload_archives, list_payload_archives())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payload archive")
    |> assign(:payload_archive, PayloadArchives.get_payload_archive!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payload archive")
    |> assign(:payload_archive, %PayloadArchive{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payload archives")
    |> assign(:payload_archive, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payload_archive = PayloadArchives.get_payload_archive!(id)
    {:ok, _} = PayloadArchives.delete_payload_archive(payload_archive)

    {:noreply, assign(socket, :payload_archives, list_payload_archives())}
  end

  defp list_payload_archives do
    PayloadArchives.list_payload_archives()
  end
end

defmodule CoreaWeb.PayloadLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Payloads
  alias Corea.Payloads.Payload

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :payloads, list_payloads())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payload")
    |> assign(:payload, Payloads.get_payload!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payload")
    |> assign(:payload, %Payload{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payloads")
    |> assign(:payload, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payload = Payloads.get_payload!(id)
    {:ok, _} = Payloads.delete_payload(payload)

    {:noreply, assign(socket, :payloads, list_payloads())}
  end

  defp list_payloads do
    Payloads.list_payloads()
  end
end

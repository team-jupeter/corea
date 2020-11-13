defmodule CoreaWeb.GPCCodeLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GPCCodes
  alias Corea.GPCCodes.GPCCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gpc_codes, list_gpc_codes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gpc code")
    |> assign(:gpc_code, GPCCodes.get_gpc_code!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gpc code")
    |> assign(:gpc_code, %GPCCode{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gpc codes")
    |> assign(:gpc_code, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gpc_code = GPCCodes.get_gpc_code!(id)
    {:ok, _} = GPCCodes.delete_gpc_code(gpc_code)

    {:noreply, assign(socket, :gpc_codes, list_gpc_codes())}
  end

  defp list_gpc_codes do
    GPCCodes.list_gpc_codes()
  end
end

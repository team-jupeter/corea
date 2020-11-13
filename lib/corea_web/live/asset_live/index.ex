defmodule CoreaWeb.AssetLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Assets
  alias Corea.Assets.Asset

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :assets, list_assets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Asset")
    |> assign(:asset, Assets.get_asset!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Asset")
    |> assign(:asset, %Asset{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Assets")
    |> assign(:asset, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    asset = Assets.get_asset!(id)
    {:ok, _} = Assets.delete_asset(asset)

    {:noreply, assign(socket, :assets, list_assets())}
  end

  defp list_assets do
    Assets.list_assets()
  end
end

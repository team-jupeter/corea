defmodule CoreaWeb.ColorCodeLive.Index do
  use CoreaWeb, :live_view

  alias Corea.ColorCodes
  alias Corea.ColorCodes.ColorCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :color_codes, list_color_codes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Color code")
    |> assign(:color_code, ColorCodes.get_color_code!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Color code")
    |> assign(:color_code, %ColorCode{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Color codes")
    |> assign(:color_code, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    color_code = ColorCodes.get_color_code!(id)
    {:ok, _} = ColorCodes.delete_color_code(color_code)

    {:noreply, assign(socket, :color_codes, list_color_codes())}
  end

  defp list_color_codes do
    ColorCodes.list_color_codes()
  end
end

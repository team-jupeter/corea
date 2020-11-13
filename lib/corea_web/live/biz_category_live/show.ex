defmodule CoreaWeb.BizCategoryLive.Show do
  use CoreaWeb, :live_view

  alias Corea.BizCategories

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:biz_category, BizCategories.get_biz_category!(id))}
  end

  defp page_title(:show), do: "Show Biz category"
  defp page_title(:edit), do: "Edit Biz category"
end

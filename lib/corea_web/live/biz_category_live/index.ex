defmodule CoreaWeb.BizCategoryLive.Index do
  use CoreaWeb, :live_view

  alias Corea.BizCategories
  alias Corea.BizCategories.BizCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :biz_categories, list_biz_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Biz category")
    |> assign(:biz_category, BizCategories.get_biz_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Biz category")
    |> assign(:biz_category, %BizCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Biz categories")
    |> assign(:biz_category, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    biz_category = BizCategories.get_biz_category!(id)
    {:ok, _} = BizCategories.delete_biz_category(biz_category)

    {:noreply, assign(socket, :biz_categories, list_biz_categories())}
  end

  defp list_biz_categories do
    BizCategories.list_biz_categories()
  end
end

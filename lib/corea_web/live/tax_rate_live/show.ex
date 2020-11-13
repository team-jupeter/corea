defmodule CoreaWeb.TaxRateLive.Show do
  use CoreaWeb, :live_view

  alias Corea.TaxRates

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tax_rate, TaxRates.get_tax_rate!(id))}
  end

  defp page_title(:show), do: "Show Tax rate"
  defp page_title(:edit), do: "Edit Tax rate"
end

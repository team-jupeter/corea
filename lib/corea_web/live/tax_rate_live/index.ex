defmodule CoreaWeb.TaxRateLive.Index do
  use CoreaWeb, :live_view

  alias Corea.TaxRates
  alias Corea.TaxRates.TaxRate

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tax_rates, list_tax_rates())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tax rate")
    |> assign(:tax_rate, TaxRates.get_tax_rate!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tax rate")
    |> assign(:tax_rate, %TaxRate{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tax rates")
    |> assign(:tax_rate, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tax_rate = TaxRates.get_tax_rate!(id)
    {:ok, _} = TaxRates.delete_tax_rate(tax_rate)

    {:noreply, assign(socket, :tax_rates, list_tax_rates())}
  end

  defp list_tax_rates do
    TaxRates.list_tax_rates()
  end
end

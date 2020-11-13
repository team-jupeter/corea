defmodule CoreaWeb.TaxRateLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.TaxRates

  @impl true
  def update(%{tax_rate: tax_rate} = assigns, socket) do
    changeset = TaxRates.change_tax_rate(tax_rate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"tax_rate" => tax_rate_params}, socket) do
    changeset =
      socket.assigns.tax_rate
      |> TaxRates.change_tax_rate(tax_rate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"tax_rate" => tax_rate_params}, socket) do
    save_tax_rate(socket, socket.assigns.action, tax_rate_params)
  end

  defp save_tax_rate(socket, :edit, tax_rate_params) do
    case TaxRates.update_tax_rate(socket.assigns.tax_rate, tax_rate_params) do
      {:ok, _tax_rate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tax rate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_tax_rate(socket, :new, tax_rate_params) do
    case TaxRates.create_tax_rate(tax_rate_params) do
      {:ok, _tax_rate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Tax rate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

defmodule CoreaWeb.FairTradeLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.FairTrades

  @impl true
  def update(%{fair_trade: fair_trade} = assigns, socket) do
    changeset = FairTrades.change_fair_trade(fair_trade)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"fair_trade" => fair_trade_params}, socket) do
    changeset =
      socket.assigns.fair_trade
      |> FairTrades.change_fair_trade(fair_trade_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"fair_trade" => fair_trade_params}, socket) do
    save_fair_trade(socket, socket.assigns.action, fair_trade_params)
  end

  defp save_fair_trade(socket, :edit, fair_trade_params) do
    case FairTrades.update_fair_trade(socket.assigns.fair_trade, fair_trade_params) do
      {:ok, _fair_trade} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fair trade updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_fair_trade(socket, :new, fair_trade_params) do
    case FairTrades.create_fair_trade(fair_trade_params) do
      {:ok, _fair_trade} ->
        {:noreply,
         socket
         |> put_flash(:info, "Fair trade created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

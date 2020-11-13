defmodule CoreaWeb.RuleLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Rules

  @impl true
  def update(%{rule: rule} = assigns, socket) do
    changeset = Rules.change_rule(rule)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"rule" => rule_params}, socket) do
    changeset =
      socket.assigns.rule
      |> Rules.change_rule(rule_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"rule" => rule_params}, socket) do
    save_rule(socket, socket.assigns.action, rule_params)
  end

  defp save_rule(socket, :edit, rule_params) do
    case Rules.update_rule(socket.assigns.rule, rule_params) do
      {:ok, _rule} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rule updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_rule(socket, :new, rule_params) do
    case Rules.create_rule(rule_params) do
      {:ok, _rule} ->
        {:noreply,
         socket
         |> put_flash(:info, "Rule created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

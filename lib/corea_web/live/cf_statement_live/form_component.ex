defmodule CoreaWeb.CFStatementLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.CFStatements

  @impl true
  def update(%{cf_statement: cf_statement} = assigns, socket) do
    changeset = CFStatements.change_cf_statement(cf_statement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"cf_statement" => cf_statement_params}, socket) do
    changeset =
      socket.assigns.cf_statement
      |> CFStatements.change_cf_statement(cf_statement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"cf_statement" => cf_statement_params}, socket) do
    save_cf_statement(socket, socket.assigns.action, cf_statement_params)
  end

  defp save_cf_statement(socket, :edit, cf_statement_params) do
    case CFStatements.update_cf_statement(socket.assigns.cf_statement, cf_statement_params) do
      {:ok, _cf_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cf statement updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_cf_statement(socket, :new, cf_statement_params) do
    case CFStatements.create_cf_statement(cf_statement_params) do
      {:ok, _cf_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Cf statement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

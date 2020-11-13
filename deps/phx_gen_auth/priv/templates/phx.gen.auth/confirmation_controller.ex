defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>ConfirmationController do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect context.module %>

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"<%= schema.singular %>" => %{"email" => email}}) do
    if <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>_by_email(email) do
      <%= inspect context.alias %>.deliver_<%= schema.singular %>_confirmation_instructions(
        <%= schema.singular %>,
        &Routes.<%= schema.route_helper %>_confirmation_url(conn, :confirm, &1)
      )
    end

    # Regardless of the outcome, show an impartial success/error message.
    conn
    |> put_flash(
      :info,
      "If your email is in our system and it has not been confirmed yet, " <>
        "you will receive an email with instructions shortly."
    )
    |> redirect(to: "/")
  end

  # Do not log in the <%= schema.singular %> after confirmation to avoid a
  # leaked token giving the <%= schema.singular %> access to the account.
  def confirm(conn, %{"token" => token}) do
    case <%= inspect context.alias %>.confirm_<%= schema.singular %>(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account confirmed successfully.")
        |> redirect(to: "/")

      :error ->
        conn
        |> put_flash(:error, "Confirmation link is invalid or it has expired.")
        |> redirect(to: "/")
    end
  end
end
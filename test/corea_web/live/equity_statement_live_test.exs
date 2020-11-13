defmodule CoreaWeb.EquityStatementLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.EquityStatements

  @create_attrs %{monetary_unit: "some monetary_unit"}
  @update_attrs %{monetary_unit: "some updated monetary_unit"}
  @invalid_attrs %{monetary_unit: nil}

  defp fixture(:equity_statement) do
    {:ok, equity_statement} = EquityStatements.create_equity_statement(@create_attrs)
    equity_statement
  end

  defp create_equity_statement(_) do
    equity_statement = fixture(:equity_statement)
    %{equity_statement: equity_statement}
  end

  describe "Index" do
    setup [:create_equity_statement]

    test "lists all equity_statements", %{conn: conn, equity_statement: equity_statement} do
      {:ok, _index_live, html} = live(conn, Routes.equity_statement_index_path(conn, :index))

      assert html =~ "Listing Equity statements"
      assert html =~ equity_statement.monetary_unit
    end

    test "saves new equity_statement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.equity_statement_index_path(conn, :index))

      assert index_live |> element("a", "New Equity statement") |> render_click() =~
               "New Equity statement"

      assert_patch(index_live, Routes.equity_statement_index_path(conn, :new))

      assert index_live
             |> form("#equity_statement-form", equity_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#equity_statement-form", equity_statement: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.equity_statement_index_path(conn, :index))

      assert html =~ "Equity statement created successfully"
      assert html =~ "some monetary_unit"
    end

    test "updates equity_statement in listing", %{conn: conn, equity_statement: equity_statement} do
      {:ok, index_live, _html} = live(conn, Routes.equity_statement_index_path(conn, :index))

      assert index_live |> element("#equity_statement-#{equity_statement.id} a", "Edit") |> render_click() =~
               "Edit Equity statement"

      assert_patch(index_live, Routes.equity_statement_index_path(conn, :edit, equity_statement))

      assert index_live
             |> form("#equity_statement-form", equity_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#equity_statement-form", equity_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.equity_statement_index_path(conn, :index))

      assert html =~ "Equity statement updated successfully"
      assert html =~ "some updated monetary_unit"
    end

    test "deletes equity_statement in listing", %{conn: conn, equity_statement: equity_statement} do
      {:ok, index_live, _html} = live(conn, Routes.equity_statement_index_path(conn, :index))

      assert index_live |> element("#equity_statement-#{equity_statement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#equity_statement-#{equity_statement.id}")
    end
  end

  describe "Show" do
    setup [:create_equity_statement]

    test "displays equity_statement", %{conn: conn, equity_statement: equity_statement} do
      {:ok, _show_live, html} = live(conn, Routes.equity_statement_show_path(conn, :show, equity_statement))

      assert html =~ "Show Equity statement"
      assert html =~ equity_statement.monetary_unit
    end

    test "updates equity_statement within modal", %{conn: conn, equity_statement: equity_statement} do
      {:ok, show_live, _html} = live(conn, Routes.equity_statement_show_path(conn, :show, equity_statement))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Equity statement"

      assert_patch(show_live, Routes.equity_statement_show_path(conn, :edit, equity_statement))

      assert show_live
             |> form("#equity_statement-form", equity_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#equity_statement-form", equity_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.equity_statement_show_path(conn, :show, equity_statement))

      assert html =~ "Equity statement updated successfully"
      assert html =~ "some updated monetary_unit"
    end
  end
end

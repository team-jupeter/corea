defmodule CoreaWeb.IncomeStatementLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.IncomeStatements

  @create_attrs %{entity_name: "some entity_name"}
  @update_attrs %{entity_name: "some updated entity_name"}
  @invalid_attrs %{entity_name: nil}

  defp fixture(:income_statement) do
    {:ok, income_statement} = IncomeStatements.create_income_statement(@create_attrs)
    income_statement
  end

  defp create_income_statement(_) do
    income_statement = fixture(:income_statement)
    %{income_statement: income_statement}
  end

  describe "Index" do
    setup [:create_income_statement]

    test "lists all income_statements", %{conn: conn, income_statement: income_statement} do
      {:ok, _index_live, html} = live(conn, Routes.income_statement_index_path(conn, :index))

      assert html =~ "Listing Income statements"
      assert html =~ income_statement.entity_name
    end

    test "saves new income_statement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.income_statement_index_path(conn, :index))

      assert index_live |> element("a", "New Income statement") |> render_click() =~
               "New Income statement"

      assert_patch(index_live, Routes.income_statement_index_path(conn, :new))

      assert index_live
             |> form("#income_statement-form", income_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#income_statement-form", income_statement: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.income_statement_index_path(conn, :index))

      assert html =~ "Income statement created successfully"
      assert html =~ "some entity_name"
    end

    test "updates income_statement in listing", %{conn: conn, income_statement: income_statement} do
      {:ok, index_live, _html} = live(conn, Routes.income_statement_index_path(conn, :index))

      assert index_live |> element("#income_statement-#{income_statement.id} a", "Edit") |> render_click() =~
               "Edit Income statement"

      assert_patch(index_live, Routes.income_statement_index_path(conn, :edit, income_statement))

      assert index_live
             |> form("#income_statement-form", income_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#income_statement-form", income_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.income_statement_index_path(conn, :index))

      assert html =~ "Income statement updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes income_statement in listing", %{conn: conn, income_statement: income_statement} do
      {:ok, index_live, _html} = live(conn, Routes.income_statement_index_path(conn, :index))

      assert index_live |> element("#income_statement-#{income_statement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#income_statement-#{income_statement.id}")
    end
  end

  describe "Show" do
    setup [:create_income_statement]

    test "displays income_statement", %{conn: conn, income_statement: income_statement} do
      {:ok, _show_live, html} = live(conn, Routes.income_statement_show_path(conn, :show, income_statement))

      assert html =~ "Show Income statement"
      assert html =~ income_statement.entity_name
    end

    test "updates income_statement within modal", %{conn: conn, income_statement: income_statement} do
      {:ok, show_live, _html} = live(conn, Routes.income_statement_show_path(conn, :show, income_statement))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Income statement"

      assert_patch(show_live, Routes.income_statement_show_path(conn, :edit, income_statement))

      assert show_live
             |> form("#income_statement-form", income_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#income_statement-form", income_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.income_statement_show_path(conn, :show, income_statement))

      assert html =~ "Income statement updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end

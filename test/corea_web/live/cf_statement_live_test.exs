defmodule CoreaWeb.CFStatementLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.CFStatements

  @create_attrs %{entity_name: "some entity_name"}
  @update_attrs %{entity_name: "some updated entity_name"}
  @invalid_attrs %{entity_name: nil}

  defp fixture(:cf_statement) do
    {:ok, cf_statement} = CFStatements.create_cf_statement(@create_attrs)
    cf_statement
  end

  defp create_cf_statement(_) do
    cf_statement = fixture(:cf_statement)
    %{cf_statement: cf_statement}
  end

  describe "Index" do
    setup [:create_cf_statement]

    test "lists all cf_statements", %{conn: conn, cf_statement: cf_statement} do
      {:ok, _index_live, html} = live(conn, Routes.cf_statement_index_path(conn, :index))

      assert html =~ "Listing Cf statements"
      assert html =~ cf_statement.entity_name
    end

    test "saves new cf_statement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.cf_statement_index_path(conn, :index))

      assert index_live |> element("a", "New Cf statement") |> render_click() =~
               "New Cf statement"

      assert_patch(index_live, Routes.cf_statement_index_path(conn, :new))

      assert index_live
             |> form("#cf_statement-form", cf_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cf_statement-form", cf_statement: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cf_statement_index_path(conn, :index))

      assert html =~ "Cf statement created successfully"
      assert html =~ "some entity_name"
    end

    test "updates cf_statement in listing", %{conn: conn, cf_statement: cf_statement} do
      {:ok, index_live, _html} = live(conn, Routes.cf_statement_index_path(conn, :index))

      assert index_live |> element("#cf_statement-#{cf_statement.id} a", "Edit") |> render_click() =~
               "Edit Cf statement"

      assert_patch(index_live, Routes.cf_statement_index_path(conn, :edit, cf_statement))

      assert index_live
             |> form("#cf_statement-form", cf_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#cf_statement-form", cf_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cf_statement_index_path(conn, :index))

      assert html =~ "Cf statement updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes cf_statement in listing", %{conn: conn, cf_statement: cf_statement} do
      {:ok, index_live, _html} = live(conn, Routes.cf_statement_index_path(conn, :index))

      assert index_live |> element("#cf_statement-#{cf_statement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cf_statement-#{cf_statement.id}")
    end
  end

  describe "Show" do
    setup [:create_cf_statement]

    test "displays cf_statement", %{conn: conn, cf_statement: cf_statement} do
      {:ok, _show_live, html} = live(conn, Routes.cf_statement_show_path(conn, :show, cf_statement))

      assert html =~ "Show Cf statement"
      assert html =~ cf_statement.entity_name
    end

    test "updates cf_statement within modal", %{conn: conn, cf_statement: cf_statement} do
      {:ok, show_live, _html} = live(conn, Routes.cf_statement_show_path(conn, :show, cf_statement))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cf statement"

      assert_patch(show_live, Routes.cf_statement_show_path(conn, :edit, cf_statement))

      assert show_live
             |> form("#cf_statement-form", cf_statement: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#cf_statement-form", cf_statement: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.cf_statement_show_path(conn, :show, cf_statement))

      assert html =~ "Cf statement updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end

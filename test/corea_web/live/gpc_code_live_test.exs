defmodule CoreaWeb.GPCCodeLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GPCCodes

  @create_attrs %{code: "some code", name: "some name", standard: "some standard"}
  @update_attrs %{code: "some updated code", name: "some updated name", standard: "some updated standard"}
  @invalid_attrs %{code: nil, name: nil, standard: nil}

  defp fixture(:gpc_code) do
    {:ok, gpc_code} = GPCCodes.create_gpc_code(@create_attrs)
    gpc_code
  end

  defp create_gpc_code(_) do
    gpc_code = fixture(:gpc_code)
    %{gpc_code: gpc_code}
  end

  describe "Index" do
    setup [:create_gpc_code]

    test "lists all gpc_codes", %{conn: conn, gpc_code: gpc_code} do
      {:ok, _index_live, html} = live(conn, Routes.gpc_code_index_path(conn, :index))

      assert html =~ "Listing Gpc codes"
      assert html =~ gpc_code.code
    end

    test "saves new gpc_code", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gpc_code_index_path(conn, :index))

      assert index_live |> element("a", "New Gpc code") |> render_click() =~
               "New Gpc code"

      assert_patch(index_live, Routes.gpc_code_index_path(conn, :new))

      assert index_live
             |> form("#gpc_code-form", gpc_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gpc_code-form", gpc_code: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gpc_code_index_path(conn, :index))

      assert html =~ "Gpc code created successfully"
      assert html =~ "some code"
    end

    test "updates gpc_code in listing", %{conn: conn, gpc_code: gpc_code} do
      {:ok, index_live, _html} = live(conn, Routes.gpc_code_index_path(conn, :index))

      assert index_live |> element("#gpc_code-#{gpc_code.id} a", "Edit") |> render_click() =~
               "Edit Gpc code"

      assert_patch(index_live, Routes.gpc_code_index_path(conn, :edit, gpc_code))

      assert index_live
             |> form("#gpc_code-form", gpc_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gpc_code-form", gpc_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gpc_code_index_path(conn, :index))

      assert html =~ "Gpc code updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes gpc_code in listing", %{conn: conn, gpc_code: gpc_code} do
      {:ok, index_live, _html} = live(conn, Routes.gpc_code_index_path(conn, :index))

      assert index_live |> element("#gpc_code-#{gpc_code.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gpc_code-#{gpc_code.id}")
    end
  end

  describe "Show" do
    setup [:create_gpc_code]

    test "displays gpc_code", %{conn: conn, gpc_code: gpc_code} do
      {:ok, _show_live, html} = live(conn, Routes.gpc_code_show_path(conn, :show, gpc_code))

      assert html =~ "Show Gpc code"
      assert html =~ gpc_code.code
    end

    test "updates gpc_code within modal", %{conn: conn, gpc_code: gpc_code} do
      {:ok, show_live, _html} = live(conn, Routes.gpc_code_show_path(conn, :show, gpc_code))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gpc code"

      assert_patch(show_live, Routes.gpc_code_show_path(conn, :edit, gpc_code))

      assert show_live
             |> form("#gpc_code-form", gpc_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gpc_code-form", gpc_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gpc_code_show_path(conn, :show, gpc_code))

      assert html =~ "Gpc code updated successfully"
      assert html =~ "some updated code"
    end
  end
end

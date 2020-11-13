defmodule CoreaWeb.GABLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GABs

  @create_attrs %{name: "some name", t1_balance: "120.5", t2_balance: "120.5", t3_balance: "120.5", t4_balance: "120.5", t5_balance: "120.5", telephones: [], unique_digits: "some unique_digits"}
  @update_attrs %{name: "some updated name", t1_balance: "456.7", t2_balance: "456.7", t3_balance: "456.7", t4_balance: "456.7", t5_balance: "456.7", telephones: [], unique_digits: "some updated unique_digits"}
  @invalid_attrs %{name: nil, t1_balance: nil, t2_balance: nil, t3_balance: nil, t4_balance: nil, t5_balance: nil, telephones: nil, unique_digits: nil}

  defp fixture(:gab) do
    {:ok, gab} = GABs.create_gab(@create_attrs)
    gab
  end

  defp create_gab(_) do
    gab = fixture(:gab)
    %{gab: gab}
  end

  describe "Index" do
    setup [:create_gab]

    test "lists all gabs", %{conn: conn, gab: gab} do
      {:ok, _index_live, html} = live(conn, Routes.gab_index_path(conn, :index))

      assert html =~ "Listing Gabs"
      assert html =~ gab.name
    end

    test "saves new gab", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gab_index_path(conn, :index))

      assert index_live |> element("a", "New Gab") |> render_click() =~
               "New Gab"

      assert_patch(index_live, Routes.gab_index_path(conn, :new))

      assert index_live
             |> form("#gab-form", gab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab-form", gab: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_index_path(conn, :index))

      assert html =~ "Gab created successfully"
      assert html =~ "some name"
    end

    test "updates gab in listing", %{conn: conn, gab: gab} do
      {:ok, index_live, _html} = live(conn, Routes.gab_index_path(conn, :index))

      assert index_live |> element("#gab-#{gab.id} a", "Edit") |> render_click() =~
               "Edit Gab"

      assert_patch(index_live, Routes.gab_index_path(conn, :edit, gab))

      assert index_live
             |> form("#gab-form", gab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab-form", gab: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_index_path(conn, :index))

      assert html =~ "Gab updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes gab in listing", %{conn: conn, gab: gab} do
      {:ok, index_live, _html} = live(conn, Routes.gab_index_path(conn, :index))

      assert index_live |> element("#gab-#{gab.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gab-#{gab.id}")
    end
  end

  describe "Show" do
    setup [:create_gab]

    test "displays gab", %{conn: conn, gab: gab} do
      {:ok, _show_live, html} = live(conn, Routes.gab_show_path(conn, :show, gab))

      assert html =~ "Show Gab"
      assert html =~ gab.name
    end

    test "updates gab within modal", %{conn: conn, gab: gab} do
      {:ok, show_live, _html} = live(conn, Routes.gab_show_path(conn, :show, gab))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gab"

      assert_patch(show_live, Routes.gab_show_path(conn, :edit, gab))

      assert show_live
             |> form("#gab-form", gab: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gab-form", gab: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_show_path(conn, :show, gab))

      assert html =~ "Gab updated successfully"
      assert html =~ "some updated name"
    end
  end
end

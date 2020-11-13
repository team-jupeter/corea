defmodule CoreaWeb.GopangLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Gopangs

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:gopang) do
    {:ok, gopang} = Gopangs.create_gopang(@create_attrs)
    gopang
  end

  defp create_gopang(_) do
    gopang = fixture(:gopang)
    %{gopang: gopang}
  end

  describe "Index" do
    setup [:create_gopang]

    test "lists all gopangs", %{conn: conn, gopang: gopang} do
      {:ok, _index_live, html} = live(conn, Routes.gopang_index_path(conn, :index))

      assert html =~ "Listing Gopangs"
      assert html =~ gopang.name
    end

    test "saves new gopang", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_index_path(conn, :index))

      assert index_live |> element("a", "New Gopang") |> render_click() =~
               "New Gopang"

      assert_patch(index_live, Routes.gopang_index_path(conn, :new))

      assert index_live
             |> form("#gopang-form", gopang: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gopang-form", gopang: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_index_path(conn, :index))

      assert html =~ "Gopang created successfully"
      assert html =~ "some name"
    end

    test "updates gopang in listing", %{conn: conn, gopang: gopang} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_index_path(conn, :index))

      assert index_live |> element("#gopang-#{gopang.id} a", "Edit") |> render_click() =~
               "Edit Gopang"

      assert_patch(index_live, Routes.gopang_index_path(conn, :edit, gopang))

      assert index_live
             |> form("#gopang-form", gopang: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gopang-form", gopang: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_index_path(conn, :index))

      assert html =~ "Gopang updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes gopang in listing", %{conn: conn, gopang: gopang} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_index_path(conn, :index))

      assert index_live |> element("#gopang-#{gopang.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gopang-#{gopang.id}")
    end
  end

  describe "Show" do
    setup [:create_gopang]

    test "displays gopang", %{conn: conn, gopang: gopang} do
      {:ok, _show_live, html} = live(conn, Routes.gopang_show_path(conn, :show, gopang))

      assert html =~ "Show Gopang"
      assert html =~ gopang.name
    end

    test "updates gopang within modal", %{conn: conn, gopang: gopang} do
      {:ok, show_live, _html} = live(conn, Routes.gopang_show_path(conn, :show, gopang))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gopang"

      assert_patch(show_live, Routes.gopang_show_path(conn, :edit, gopang))

      assert show_live
             |> form("#gopang-form", gopang: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gopang-form", gopang: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_show_path(conn, :show, gopang))

      assert html =~ "Gopang updated successfully"
      assert html =~ "some updated name"
    end
  end
end

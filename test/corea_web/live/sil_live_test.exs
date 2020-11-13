defmodule CoreaWeb.SilLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Sils

  @create_attrs %{current_hash: "some current_hash"}
  @update_attrs %{current_hash: "some updated current_hash"}
  @invalid_attrs %{current_hash: nil}

  defp fixture(:sil) do
    {:ok, sil} = Sils.create_sil(@create_attrs)
    sil
  end

  defp create_sil(_) do
    sil = fixture(:sil)
    %{sil: sil}
  end

  describe "Index" do
    setup [:create_sil]

    test "lists all sils", %{conn: conn, sil: sil} do
      {:ok, _index_live, html} = live(conn, Routes.sil_index_path(conn, :index))

      assert html =~ "Listing Sils"
      assert html =~ sil.current_hash
    end

    test "saves new sil", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.sil_index_path(conn, :index))

      assert index_live |> element("a", "New Sil") |> render_click() =~
               "New Sil"

      assert_patch(index_live, Routes.sil_index_path(conn, :new))

      assert index_live
             |> form("#sil-form", sil: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sil-form", sil: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sil_index_path(conn, :index))

      assert html =~ "Sil created successfully"
      assert html =~ "some current_hash"
    end

    test "updates sil in listing", %{conn: conn, sil: sil} do
      {:ok, index_live, _html} = live(conn, Routes.sil_index_path(conn, :index))

      assert index_live |> element("#sil-#{sil.id} a", "Edit") |> render_click() =~
               "Edit Sil"

      assert_patch(index_live, Routes.sil_index_path(conn, :edit, sil))

      assert index_live
             |> form("#sil-form", sil: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#sil-form", sil: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sil_index_path(conn, :index))

      assert html =~ "Sil updated successfully"
      assert html =~ "some updated current_hash"
    end

    test "deletes sil in listing", %{conn: conn, sil: sil} do
      {:ok, index_live, _html} = live(conn, Routes.sil_index_path(conn, :index))

      assert index_live |> element("#sil-#{sil.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sil-#{sil.id}")
    end
  end

  describe "Show" do
    setup [:create_sil]

    test "displays sil", %{conn: conn, sil: sil} do
      {:ok, _show_live, html} = live(conn, Routes.sil_show_path(conn, :show, sil))

      assert html =~ "Show Sil"
      assert html =~ sil.current_hash
    end

    test "updates sil within modal", %{conn: conn, sil: sil} do
      {:ok, show_live, _html} = live(conn, Routes.sil_show_path(conn, :show, sil))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sil"

      assert_patch(show_live, Routes.sil_show_path(conn, :edit, sil))

      assert show_live
             |> form("#sil-form", sil: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#sil-form", sil: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.sil_show_path(conn, :show, sil))

      assert html =~ "Sil updated successfully"
      assert html =~ "some updated current_hash"
    end
  end
end

defmodule CoreaWeb.GlobalSupulLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GlobalSupuls

  @create_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", openhash_box: [], t1_balance: "120.5", type: "some type"}
  @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", openhash_box: [], t1_balance: "456.7", type: "some updated type"}
  @invalid_attrs %{auth_code: nil, current_hash: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, openhash_box: nil, t1_balance: nil, type: nil}

  defp fixture(:global_supul) do
    {:ok, global_supul} = GlobalSupuls.create_global_supul(@create_attrs)
    global_supul
  end

  defp create_global_supul(_) do
    global_supul = fixture(:global_supul)
    %{global_supul: global_supul}
  end

  describe "Index" do
    setup [:create_global_supul]

    test "lists all global_supuls", %{conn: conn, global_supul: global_supul} do
      {:ok, _index_live, html} = live(conn, Routes.global_supul_index_path(conn, :index))

      assert html =~ "Listing Global supuls"
      assert html =~ global_supul.auth_code
    end

    test "saves new global_supul", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.global_supul_index_path(conn, :index))

      assert index_live |> element("a", "New Global supul") |> render_click() =~
               "New Global supul"

      assert_patch(index_live, Routes.global_supul_index_path(conn, :new))

      assert index_live
             |> form("#global_supul-form", global_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#global_supul-form", global_supul: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.global_supul_index_path(conn, :index))

      assert html =~ "Global supul created successfully"
      assert html =~ "some auth_code"
    end

    test "updates global_supul in listing", %{conn: conn, global_supul: global_supul} do
      {:ok, index_live, _html} = live(conn, Routes.global_supul_index_path(conn, :index))

      assert index_live |> element("#global_supul-#{global_supul.id} a", "Edit") |> render_click() =~
               "Edit Global supul"

      assert_patch(index_live, Routes.global_supul_index_path(conn, :edit, global_supul))

      assert index_live
             |> form("#global_supul-form", global_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#global_supul-form", global_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.global_supul_index_path(conn, :index))

      assert html =~ "Global supul updated successfully"
      assert html =~ "some updated auth_code"
    end

    test "deletes global_supul in listing", %{conn: conn, global_supul: global_supul} do
      {:ok, index_live, _html} = live(conn, Routes.global_supul_index_path(conn, :index))

      assert index_live |> element("#global_supul-#{global_supul.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#global_supul-#{global_supul.id}")
    end
  end

  describe "Show" do
    setup [:create_global_supul]

    test "displays global_supul", %{conn: conn, global_supul: global_supul} do
      {:ok, _show_live, html} = live(conn, Routes.global_supul_show_path(conn, :show, global_supul))

      assert html =~ "Show Global supul"
      assert html =~ global_supul.auth_code
    end

    test "updates global_supul within modal", %{conn: conn, global_supul: global_supul} do
      {:ok, show_live, _html} = live(conn, Routes.global_supul_show_path(conn, :show, global_supul))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Global supul"

      assert_patch(show_live, Routes.global_supul_show_path(conn, :edit, global_supul))

      assert show_live
             |> form("#global_supul-form", global_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#global_supul-form", global_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.global_supul_show_path(conn, :show, global_supul))

      assert html =~ "Global supul updated successfully"
      assert html =~ "some updated auth_code"
    end
  end
end

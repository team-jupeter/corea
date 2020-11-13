defmodule CoreaWeb.NationSupulLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.NationSupuls

  @create_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", global_openhash_id: "7488a646-e31f-11e4-aace-600308960662", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", nation_name: "some nation_name", nation_supul_code: "some nation_supul_code", openhash_box: [], previous_hash: "some previous_hash", sender: "7488a646-e31f-11e4-aace-600308960662", t1_balance: "120.5", type: "some type"}
  @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", global_openhash_id: "7488a646-e31f-11e4-aace-600308960668", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", nation_name: "some updated nation_name", nation_supul_code: "some updated nation_supul_code", openhash_box: [], previous_hash: "some updated previous_hash", sender: "7488a646-e31f-11e4-aace-600308960668", t1_balance: "456.7", type: "some updated type"}
  @invalid_attrs %{auth_code: nil, current_hash: nil, global_openhash_id: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, nation_name: nil, nation_supul_code: nil, openhash_box: nil, previous_hash: nil, sender: nil, t1_balance: nil, type: nil}

  defp fixture(:nation_supul) do
    {:ok, nation_supul} = NationSupuls.create_nation_supul(@create_attrs)
    nation_supul
  end

  defp create_nation_supul(_) do
    nation_supul = fixture(:nation_supul)
    %{nation_supul: nation_supul}
  end

  describe "Index" do
    setup [:create_nation_supul]

    test "lists all nation_supuls", %{conn: conn, nation_supul: nation_supul} do
      {:ok, _index_live, html} = live(conn, Routes.nation_supul_index_path(conn, :index))

      assert html =~ "Listing Nation supuls"
      assert html =~ nation_supul.auth_code
    end

    test "saves new nation_supul", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.nation_supul_index_path(conn, :index))

      assert index_live |> element("a", "New Nation supul") |> render_click() =~
               "New Nation supul"

      assert_patch(index_live, Routes.nation_supul_index_path(conn, :new))

      assert index_live
             |> form("#nation_supul-form", nation_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nation_supul-form", nation_supul: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_supul_index_path(conn, :index))

      assert html =~ "Nation supul created successfully"
      assert html =~ "some auth_code"
    end

    test "updates nation_supul in listing", %{conn: conn, nation_supul: nation_supul} do
      {:ok, index_live, _html} = live(conn, Routes.nation_supul_index_path(conn, :index))

      assert index_live |> element("#nation_supul-#{nation_supul.id} a", "Edit") |> render_click() =~
               "Edit Nation supul"

      assert_patch(index_live, Routes.nation_supul_index_path(conn, :edit, nation_supul))

      assert index_live
             |> form("#nation_supul-form", nation_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nation_supul-form", nation_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_supul_index_path(conn, :index))

      assert html =~ "Nation supul updated successfully"
      assert html =~ "some updated auth_code"
    end

    test "deletes nation_supul in listing", %{conn: conn, nation_supul: nation_supul} do
      {:ok, index_live, _html} = live(conn, Routes.nation_supul_index_path(conn, :index))

      assert index_live |> element("#nation_supul-#{nation_supul.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#nation_supul-#{nation_supul.id}")
    end
  end

  describe "Show" do
    setup [:create_nation_supul]

    test "displays nation_supul", %{conn: conn, nation_supul: nation_supul} do
      {:ok, _show_live, html} = live(conn, Routes.nation_supul_show_path(conn, :show, nation_supul))

      assert html =~ "Show Nation supul"
      assert html =~ nation_supul.auth_code
    end

    test "updates nation_supul within modal", %{conn: conn, nation_supul: nation_supul} do
      {:ok, show_live, _html} = live(conn, Routes.nation_supul_show_path(conn, :show, nation_supul))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Nation supul"

      assert_patch(show_live, Routes.nation_supul_show_path(conn, :edit, nation_supul))

      assert show_live
             |> form("#nation_supul-form", nation_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#nation_supul-form", nation_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_supul_show_path(conn, :show, nation_supul))

      assert html =~ "Nation supul updated successfully"
      assert html =~ "some updated auth_code"
    end
  end
end

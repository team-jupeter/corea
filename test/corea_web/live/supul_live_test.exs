defmodule CoreaWeb.SupulLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Supuls

  @create_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", event_sender: "some event_sender", geographical_area: "some geographical_area", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", nation_name: "some nation_name", openhash_box: [], previous_hash: "some previous_hash", state_name: "some state_name", state_openhash_id: "7488a646-e31f-11e4-aace-600308960662", supul_code: "some supul_code", supul_name: "some supul_name", t1_balance: "120.5", txn_id: "7488a646-e31f-11e4-aace-600308960662", type: "some type"}
  @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", event_sender: "some updated event_sender", geographical_area: "some updated geographical_area", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", nation_name: "some updated nation_name", openhash_box: [], previous_hash: "some updated previous_hash", state_name: "some updated state_name", state_openhash_id: "7488a646-e31f-11e4-aace-600308960668", supul_code: "some updated supul_code", supul_name: "some updated supul_name", t1_balance: "456.7", txn_id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type"}
  @invalid_attrs %{auth_code: nil, current_hash: nil, event_sender: nil, geographical_area: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, nation_name: nil, openhash_box: nil, previous_hash: nil, state_name: nil, state_openhash_id: nil, supul_code: nil, supul_name: nil, t1_balance: nil, txn_id: nil, type: nil}

  defp fixture(:supul) do
    {:ok, supul} = Supuls.create_supul(@create_attrs)
    supul
  end

  defp create_supul(_) do
    supul = fixture(:supul)
    %{supul: supul}
  end

  describe "Index" do
    setup [:create_supul]

    test "lists all supuls", %{conn: conn, supul: supul} do
      {:ok, _index_live, html} = live(conn, Routes.supul_index_path(conn, :index))

      assert html =~ "Listing Supuls"
      assert html =~ supul.auth_code
    end

    test "saves new supul", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.supul_index_path(conn, :index))

      assert index_live |> element("a", "New Supul") |> render_click() =~
               "New Supul"

      assert_patch(index_live, Routes.supul_index_path(conn, :new))

      assert index_live
             |> form("#supul-form", supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supul-form", supul: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_index_path(conn, :index))

      assert html =~ "Supul created successfully"
      assert html =~ "some auth_code"
    end

    test "updates supul in listing", %{conn: conn, supul: supul} do
      {:ok, index_live, _html} = live(conn, Routes.supul_index_path(conn, :index))

      assert index_live |> element("#supul-#{supul.id} a", "Edit") |> render_click() =~
               "Edit Supul"

      assert_patch(index_live, Routes.supul_index_path(conn, :edit, supul))

      assert index_live
             |> form("#supul-form", supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supul-form", supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_index_path(conn, :index))

      assert html =~ "Supul updated successfully"
      assert html =~ "some updated auth_code"
    end

    test "deletes supul in listing", %{conn: conn, supul: supul} do
      {:ok, index_live, _html} = live(conn, Routes.supul_index_path(conn, :index))

      assert index_live |> element("#supul-#{supul.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#supul-#{supul.id}")
    end
  end

  describe "Show" do
    setup [:create_supul]

    test "displays supul", %{conn: conn, supul: supul} do
      {:ok, _show_live, html} = live(conn, Routes.supul_show_path(conn, :show, supul))

      assert html =~ "Show Supul"
      assert html =~ supul.auth_code
    end

    test "updates supul within modal", %{conn: conn, supul: supul} do
      {:ok, show_live, _html} = live(conn, Routes.supul_show_path(conn, :show, supul))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Supul"

      assert_patch(show_live, Routes.supul_show_path(conn, :edit, supul))

      assert show_live
             |> form("#supul-form", supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#supul-form", supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_show_path(conn, :show, supul))

      assert html =~ "Supul updated successfully"
      assert html =~ "some updated auth_code"
    end
  end
end

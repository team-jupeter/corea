defmodule CoreaWeb.StateSupulLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.StateSupuls

  @create_attrs %{auth_code: "some auth_code", current_hash: "some current_hash", hash_chain: [], hash_count: 42, incoming_hash: "some incoming_hash", name: "some name", openhash_box: [], t1_balance: "120.5", type: "some type"}
  @update_attrs %{auth_code: "some updated auth_code", current_hash: "some updated current_hash", hash_chain: [], hash_count: 43, incoming_hash: "some updated incoming_hash", name: "some updated name", openhash_box: [], t1_balance: "456.7", type: "some updated type"}
  @invalid_attrs %{auth_code: nil, current_hash: nil, hash_chain: nil, hash_count: nil, incoming_hash: nil, name: nil, openhash_box: nil, t1_balance: nil, type: nil}

  defp fixture(:state_supul) do
    {:ok, state_supul} = StateSupuls.create_state_supul(@create_attrs)
    state_supul
  end

  defp create_state_supul(_) do
    state_supul = fixture(:state_supul)
    %{state_supul: state_supul}
  end

  describe "Index" do
    setup [:create_state_supul]

    test "lists all state_supuls", %{conn: conn, state_supul: state_supul} do
      {:ok, _index_live, html} = live(conn, Routes.state_supul_index_path(conn, :index))

      assert html =~ "Listing State supuls"
      assert html =~ state_supul.auth_code
    end

    test "saves new state_supul", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.state_supul_index_path(conn, :index))

      assert index_live |> element("a", "New State supul") |> render_click() =~
               "New State supul"

      assert_patch(index_live, Routes.state_supul_index_path(conn, :new))

      assert index_live
             |> form("#state_supul-form", state_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#state_supul-form", state_supul: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.state_supul_index_path(conn, :index))

      assert html =~ "State supul created successfully"
      assert html =~ "some auth_code"
    end

    test "updates state_supul in listing", %{conn: conn, state_supul: state_supul} do
      {:ok, index_live, _html} = live(conn, Routes.state_supul_index_path(conn, :index))

      assert index_live |> element("#state_supul-#{state_supul.id} a", "Edit") |> render_click() =~
               "Edit State supul"

      assert_patch(index_live, Routes.state_supul_index_path(conn, :edit, state_supul))

      assert index_live
             |> form("#state_supul-form", state_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#state_supul-form", state_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.state_supul_index_path(conn, :index))

      assert html =~ "State supul updated successfully"
      assert html =~ "some updated auth_code"
    end

    test "deletes state_supul in listing", %{conn: conn, state_supul: state_supul} do
      {:ok, index_live, _html} = live(conn, Routes.state_supul_index_path(conn, :index))

      assert index_live |> element("#state_supul-#{state_supul.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#state_supul-#{state_supul.id}")
    end
  end

  describe "Show" do
    setup [:create_state_supul]

    test "displays state_supul", %{conn: conn, state_supul: state_supul} do
      {:ok, _show_live, html} = live(conn, Routes.state_supul_show_path(conn, :show, state_supul))

      assert html =~ "Show State supul"
      assert html =~ state_supul.auth_code
    end

    test "updates state_supul within modal", %{conn: conn, state_supul: state_supul} do
      {:ok, show_live, _html} = live(conn, Routes.state_supul_show_path(conn, :show, state_supul))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit State supul"

      assert_patch(show_live, Routes.state_supul_show_path(conn, :edit, state_supul))

      assert show_live
             |> form("#state_supul-form", state_supul: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#state_supul-form", state_supul: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.state_supul_show_path(conn, :show, state_supul))

      assert html =~ "State supul updated successfully"
      assert html =~ "some updated auth_code"
    end
  end
end

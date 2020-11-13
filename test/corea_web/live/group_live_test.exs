defmodule CoreaWeb.GroupLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Groups

  @create_attrs %{name: "some name", t1_balance: "120.5", type: "some type"}
  @update_attrs %{name: "some updated name", t1_balance: "456.7", type: "some updated type"}
  @invalid_attrs %{name: nil, t1_balance: nil, type: nil}

  defp fixture(:group) do
    {:ok, group} = Groups.create_group(@create_attrs)
    group
  end

  defp create_group(_) do
    group = fixture(:group)
    %{group: group}
  end

  describe "Index" do
    setup [:create_group]

    test "lists all groups", %{conn: conn, group: group} do
      {:ok, _index_live, html} = live(conn, Routes.group_index_path(conn, :index))

      assert html =~ "Listing Groups"
      assert html =~ group.name
    end

    test "saves new group", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.group_index_path(conn, :index))

      assert index_live |> element("a", "New Group") |> render_click() =~
               "New Group"

      assert_patch(index_live, Routes.group_index_path(conn, :new))

      assert index_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#group-form", group: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.group_index_path(conn, :index))

      assert html =~ "Group created successfully"
      assert html =~ "some name"
    end

    test "updates group in listing", %{conn: conn, group: group} do
      {:ok, index_live, _html} = live(conn, Routes.group_index_path(conn, :index))

      assert index_live |> element("#group-#{group.id} a", "Edit") |> render_click() =~
               "Edit Group"

      assert_patch(index_live, Routes.group_index_path(conn, :edit, group))

      assert index_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#group-form", group: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.group_index_path(conn, :index))

      assert html =~ "Group updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes group in listing", %{conn: conn, group: group} do
      {:ok, index_live, _html} = live(conn, Routes.group_index_path(conn, :index))

      assert index_live |> element("#group-#{group.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#group-#{group.id}")
    end
  end

  describe "Show" do
    setup [:create_group]

    test "displays group", %{conn: conn, group: group} do
      {:ok, _show_live, html} = live(conn, Routes.group_show_path(conn, :show, group))

      assert html =~ "Show Group"
      assert html =~ group.name
    end

    test "updates group within modal", %{conn: conn, group: group} do
      {:ok, show_live, _html} = live(conn, Routes.group_show_path(conn, :show, group))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Group"

      assert_patch(show_live, Routes.group_show_path(conn, :edit, group))

      assert show_live
             |> form("#group-form", group: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#group-form", group: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.group_show_path(conn, :show, group))

      assert html =~ "Group updated successfully"
      assert html =~ "some updated name"
    end
  end
end

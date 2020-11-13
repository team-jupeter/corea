defmodule CoreaWeb.T4PoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T4Pools

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:t4_pool) do
    {:ok, t4_pool} = T4Pools.create_t4_pool(@create_attrs)
    t4_pool
  end

  defp create_t4_pool(_) do
    t4_pool = fixture(:t4_pool)
    %{t4_pool: t4_pool}
  end

  describe "Index" do
    setup [:create_t4_pool]

    test "lists all t4_pools", %{conn: conn, t4_pool: t4_pool} do
      {:ok, _index_live, html} = live(conn, Routes.t4_pool_index_path(conn, :index))

      assert html =~ "Listing T4 pools"
      assert html =~ t4_pool.name
    end

    test "saves new t4_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t4_pool_index_path(conn, :index))

      assert index_live |> element("a", "New T4 pool") |> render_click() =~
               "New T4 pool"

      assert_patch(index_live, Routes.t4_pool_index_path(conn, :new))

      assert index_live
             |> form("#t4_pool-form", t4_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t4_pool-form", t4_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_pool_index_path(conn, :index))

      assert html =~ "T4 pool created successfully"
      assert html =~ "some name"
    end

    test "updates t4_pool in listing", %{conn: conn, t4_pool: t4_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t4_pool_index_path(conn, :index))

      assert index_live |> element("#t4_pool-#{t4_pool.id} a", "Edit") |> render_click() =~
               "Edit T4 pool"

      assert_patch(index_live, Routes.t4_pool_index_path(conn, :edit, t4_pool))

      assert index_live
             |> form("#t4_pool-form", t4_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t4_pool-form", t4_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_pool_index_path(conn, :index))

      assert html =~ "T4 pool updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes t4_pool in listing", %{conn: conn, t4_pool: t4_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t4_pool_index_path(conn, :index))

      assert index_live |> element("#t4_pool-#{t4_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t4_pool-#{t4_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_t4_pool]

    test "displays t4_pool", %{conn: conn, t4_pool: t4_pool} do
      {:ok, _show_live, html} = live(conn, Routes.t4_pool_show_path(conn, :show, t4_pool))

      assert html =~ "Show T4 pool"
      assert html =~ t4_pool.name
    end

    test "updates t4_pool within modal", %{conn: conn, t4_pool: t4_pool} do
      {:ok, show_live, _html} = live(conn, Routes.t4_pool_show_path(conn, :show, t4_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T4 pool"

      assert_patch(show_live, Routes.t4_pool_show_path(conn, :edit, t4_pool))

      assert show_live
             |> form("#t4_pool-form", t4_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t4_pool-form", t4_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_pool_show_path(conn, :show, t4_pool))

      assert html =~ "T4 pool updated successfully"
      assert html =~ "some updated name"
    end
  end
end

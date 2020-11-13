defmodule CoreaWeb.T2PoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T2Pools

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:t2_pool) do
    {:ok, t2_pool} = T2Pools.create_t2_pool(@create_attrs)
    t2_pool
  end

  defp create_t2_pool(_) do
    t2_pool = fixture(:t2_pool)
    %{t2_pool: t2_pool}
  end

  describe "Index" do
    setup [:create_t2_pool]

    test "lists all t2_pools", %{conn: conn, t2_pool: t2_pool} do
      {:ok, _index_live, html} = live(conn, Routes.t2_pool_index_path(conn, :index))

      assert html =~ "Listing T2 pools"
      assert html =~ t2_pool.name
    end

    test "saves new t2_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t2_pool_index_path(conn, :index))

      assert index_live |> element("a", "New T2 pool") |> render_click() =~
               "New T2 pool"

      assert_patch(index_live, Routes.t2_pool_index_path(conn, :new))

      assert index_live
             |> form("#t2_pool-form", t2_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t2_pool-form", t2_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_pool_index_path(conn, :index))

      assert html =~ "T2 pool created successfully"
      assert html =~ "some name"
    end

    test "updates t2_pool in listing", %{conn: conn, t2_pool: t2_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t2_pool_index_path(conn, :index))

      assert index_live |> element("#t2_pool-#{t2_pool.id} a", "Edit") |> render_click() =~
               "Edit T2 pool"

      assert_patch(index_live, Routes.t2_pool_index_path(conn, :edit, t2_pool))

      assert index_live
             |> form("#t2_pool-form", t2_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t2_pool-form", t2_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_pool_index_path(conn, :index))

      assert html =~ "T2 pool updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes t2_pool in listing", %{conn: conn, t2_pool: t2_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t2_pool_index_path(conn, :index))

      assert index_live |> element("#t2_pool-#{t2_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t2_pool-#{t2_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_t2_pool]

    test "displays t2_pool", %{conn: conn, t2_pool: t2_pool} do
      {:ok, _show_live, html} = live(conn, Routes.t2_pool_show_path(conn, :show, t2_pool))

      assert html =~ "Show T2 pool"
      assert html =~ t2_pool.name
    end

    test "updates t2_pool within modal", %{conn: conn, t2_pool: t2_pool} do
      {:ok, show_live, _html} = live(conn, Routes.t2_pool_show_path(conn, :show, t2_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T2 pool"

      assert_patch(show_live, Routes.t2_pool_show_path(conn, :edit, t2_pool))

      assert show_live
             |> form("#t2_pool-form", t2_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t2_pool-form", t2_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_pool_show_path(conn, :show, t2_pool))

      assert html =~ "T2 pool updated successfully"
      assert html =~ "some updated name"
    end
  end
end

defmodule CoreaWeb.T1PoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T1Pools

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:t1_pool) do
    {:ok, t1_pool} = T1Pools.create_t1_pool(@create_attrs)
    t1_pool
  end

  defp create_t1_pool(_) do
    t1_pool = fixture(:t1_pool)
    %{t1_pool: t1_pool}
  end

  describe "Index" do
    setup [:create_t1_pool]

    test "lists all t1_pools", %{conn: conn, t1_pool: t1_pool} do
      {:ok, _index_live, html} = live(conn, Routes.t1_pool_index_path(conn, :index))

      assert html =~ "Listing T1 pools"
      assert html =~ t1_pool.name
    end

    test "saves new t1_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t1_pool_index_path(conn, :index))

      assert index_live |> element("a", "New T1 pool") |> render_click() =~
               "New T1 pool"

      assert_patch(index_live, Routes.t1_pool_index_path(conn, :new))

      assert index_live
             |> form("#t1_pool-form", t1_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t1_pool-form", t1_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_pool_index_path(conn, :index))

      assert html =~ "T1 pool created successfully"
      assert html =~ "some name"
    end

    test "updates t1_pool in listing", %{conn: conn, t1_pool: t1_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t1_pool_index_path(conn, :index))

      assert index_live |> element("#t1_pool-#{t1_pool.id} a", "Edit") |> render_click() =~
               "Edit T1 pool"

      assert_patch(index_live, Routes.t1_pool_index_path(conn, :edit, t1_pool))

      assert index_live
             |> form("#t1_pool-form", t1_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t1_pool-form", t1_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_pool_index_path(conn, :index))

      assert html =~ "T1 pool updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes t1_pool in listing", %{conn: conn, t1_pool: t1_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t1_pool_index_path(conn, :index))

      assert index_live |> element("#t1_pool-#{t1_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t1_pool-#{t1_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_t1_pool]

    test "displays t1_pool", %{conn: conn, t1_pool: t1_pool} do
      {:ok, _show_live, html} = live(conn, Routes.t1_pool_show_path(conn, :show, t1_pool))

      assert html =~ "Show T1 pool"
      assert html =~ t1_pool.name
    end

    test "updates t1_pool within modal", %{conn: conn, t1_pool: t1_pool} do
      {:ok, show_live, _html} = live(conn, Routes.t1_pool_show_path(conn, :show, t1_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T1 pool"

      assert_patch(show_live, Routes.t1_pool_show_path(conn, :edit, t1_pool))

      assert show_live
             |> form("#t1_pool-form", t1_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t1_pool-form", t1_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_pool_show_path(conn, :show, t1_pool))

      assert html =~ "T1 pool updated successfully"
      assert html =~ "some updated name"
    end
  end
end

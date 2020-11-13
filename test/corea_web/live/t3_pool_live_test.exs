defmodule CoreaWeb.T3PoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T3Pools

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:t3_pool) do
    {:ok, t3_pool} = T3Pools.create_t3_pool(@create_attrs)
    t3_pool
  end

  defp create_t3_pool(_) do
    t3_pool = fixture(:t3_pool)
    %{t3_pool: t3_pool}
  end

  describe "Index" do
    setup [:create_t3_pool]

    test "lists all t3_pools", %{conn: conn, t3_pool: t3_pool} do
      {:ok, _index_live, html} = live(conn, Routes.t3_pool_index_path(conn, :index))

      assert html =~ "Listing T3 pools"
      assert html =~ t3_pool.name
    end

    test "saves new t3_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t3_pool_index_path(conn, :index))

      assert index_live |> element("a", "New T3 pool") |> render_click() =~
               "New T3 pool"

      assert_patch(index_live, Routes.t3_pool_index_path(conn, :new))

      assert index_live
             |> form("#t3_pool-form", t3_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t3_pool-form", t3_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_pool_index_path(conn, :index))

      assert html =~ "T3 pool created successfully"
      assert html =~ "some name"
    end

    test "updates t3_pool in listing", %{conn: conn, t3_pool: t3_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t3_pool_index_path(conn, :index))

      assert index_live |> element("#t3_pool-#{t3_pool.id} a", "Edit") |> render_click() =~
               "Edit T3 pool"

      assert_patch(index_live, Routes.t3_pool_index_path(conn, :edit, t3_pool))

      assert index_live
             |> form("#t3_pool-form", t3_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t3_pool-form", t3_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_pool_index_path(conn, :index))

      assert html =~ "T3 pool updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes t3_pool in listing", %{conn: conn, t3_pool: t3_pool} do
      {:ok, index_live, _html} = live(conn, Routes.t3_pool_index_path(conn, :index))

      assert index_live |> element("#t3_pool-#{t3_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t3_pool-#{t3_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_t3_pool]

    test "displays t3_pool", %{conn: conn, t3_pool: t3_pool} do
      {:ok, _show_live, html} = live(conn, Routes.t3_pool_show_path(conn, :show, t3_pool))

      assert html =~ "Show T3 pool"
      assert html =~ t3_pool.name
    end

    test "updates t3_pool within modal", %{conn: conn, t3_pool: t3_pool} do
      {:ok, show_live, _html} = live(conn, Routes.t3_pool_show_path(conn, :show, t3_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T3 pool"

      assert_patch(show_live, Routes.t3_pool_show_path(conn, :edit, t3_pool))

      assert show_live
             |> form("#t3_pool-form", t3_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t3_pool-form", t3_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_pool_show_path(conn, :show, t3_pool))

      assert html =~ "T3 pool updated successfully"
      assert html =~ "some updated name"
    end
  end
end

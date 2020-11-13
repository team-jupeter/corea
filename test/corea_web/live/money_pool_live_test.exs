defmodule CoreaWeb.MoneyPoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.MoneyPools

  @create_attrs %{t1: "120.5"}
  @update_attrs %{t1: "456.7"}
  @invalid_attrs %{t1: nil}

  defp fixture(:money_pool) do
    {:ok, money_pool} = MoneyPools.create_money_pool(@create_attrs)
    money_pool
  end

  defp create_money_pool(_) do
    money_pool = fixture(:money_pool)
    %{money_pool: money_pool}
  end

  describe "Index" do
    setup [:create_money_pool]

    test "lists all money_pools", %{conn: conn, money_pool: money_pool} do
      {:ok, _index_live, html} = live(conn, Routes.money_pool_index_path(conn, :index))

      assert html =~ "Listing Money pools"
    end

    test "saves new money_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.money_pool_index_path(conn, :index))

      assert index_live |> element("a", "New Money pool") |> render_click() =~
               "New Money pool"

      assert_patch(index_live, Routes.money_pool_index_path(conn, :new))

      assert index_live
             |> form("#money_pool-form", money_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#money_pool-form", money_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.money_pool_index_path(conn, :index))

      assert html =~ "Money pool created successfully"
    end

    test "updates money_pool in listing", %{conn: conn, money_pool: money_pool} do
      {:ok, index_live, _html} = live(conn, Routes.money_pool_index_path(conn, :index))

      assert index_live |> element("#money_pool-#{money_pool.id} a", "Edit") |> render_click() =~
               "Edit Money pool"

      assert_patch(index_live, Routes.money_pool_index_path(conn, :edit, money_pool))

      assert index_live
             |> form("#money_pool-form", money_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#money_pool-form", money_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.money_pool_index_path(conn, :index))

      assert html =~ "Money pool updated successfully"
    end

    test "deletes money_pool in listing", %{conn: conn, money_pool: money_pool} do
      {:ok, index_live, _html} = live(conn, Routes.money_pool_index_path(conn, :index))

      assert index_live |> element("#money_pool-#{money_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#money_pool-#{money_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_money_pool]

    test "displays money_pool", %{conn: conn, money_pool: money_pool} do
      {:ok, _show_live, html} = live(conn, Routes.money_pool_show_path(conn, :show, money_pool))

      assert html =~ "Show Money pool"
    end

    test "updates money_pool within modal", %{conn: conn, money_pool: money_pool} do
      {:ok, show_live, _html} = live(conn, Routes.money_pool_show_path(conn, :show, money_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Money pool"

      assert_patch(show_live, Routes.money_pool_show_path(conn, :edit, money_pool))

      assert show_live
             |> form("#money_pool-form", money_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#money_pool-form", money_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.money_pool_show_path(conn, :show, money_pool))

      assert html =~ "Money pool updated successfully"
    end
  end
end

defmodule CoreaWeb.FiatPoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.FiatPools

  @create_attrs %{aed: "120.5"}
  @update_attrs %{aed: "456.7"}
  @invalid_attrs %{aed: nil}

  defp fixture(:fiat_pool) do
    {:ok, fiat_pool} = FiatPools.create_fiat_pool(@create_attrs)
    fiat_pool
  end

  defp create_fiat_pool(_) do
    fiat_pool = fixture(:fiat_pool)
    %{fiat_pool: fiat_pool}
  end

  describe "Index" do
    setup [:create_fiat_pool]

    test "lists all fiat_pools", %{conn: conn, fiat_pool: fiat_pool} do
      {:ok, _index_live, html} = live(conn, Routes.fiat_pool_index_path(conn, :index))

      assert html =~ "Listing Fiat pools"
    end

    test "saves new fiat_pool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.fiat_pool_index_path(conn, :index))

      assert index_live |> element("a", "New Fiat pool") |> render_click() =~
               "New Fiat pool"

      assert_patch(index_live, Routes.fiat_pool_index_path(conn, :new))

      assert index_live
             |> form("#fiat_pool-form", fiat_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fiat_pool-form", fiat_pool: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fiat_pool_index_path(conn, :index))

      assert html =~ "Fiat pool created successfully"
    end

    test "updates fiat_pool in listing", %{conn: conn, fiat_pool: fiat_pool} do
      {:ok, index_live, _html} = live(conn, Routes.fiat_pool_index_path(conn, :index))

      assert index_live |> element("#fiat_pool-#{fiat_pool.id} a", "Edit") |> render_click() =~
               "Edit Fiat pool"

      assert_patch(index_live, Routes.fiat_pool_index_path(conn, :edit, fiat_pool))

      assert index_live
             |> form("#fiat_pool-form", fiat_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fiat_pool-form", fiat_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fiat_pool_index_path(conn, :index))

      assert html =~ "Fiat pool updated successfully"
    end

    test "deletes fiat_pool in listing", %{conn: conn, fiat_pool: fiat_pool} do
      {:ok, index_live, _html} = live(conn, Routes.fiat_pool_index_path(conn, :index))

      assert index_live |> element("#fiat_pool-#{fiat_pool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fiat_pool-#{fiat_pool.id}")
    end
  end

  describe "Show" do
    setup [:create_fiat_pool]

    test "displays fiat_pool", %{conn: conn, fiat_pool: fiat_pool} do
      {:ok, _show_live, html} = live(conn, Routes.fiat_pool_show_path(conn, :show, fiat_pool))

      assert html =~ "Show Fiat pool"
    end

    test "updates fiat_pool within modal", %{conn: conn, fiat_pool: fiat_pool} do
      {:ok, show_live, _html} = live(conn, Routes.fiat_pool_show_path(conn, :show, fiat_pool))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fiat pool"

      assert_patch(show_live, Routes.fiat_pool_show_path(conn, :edit, fiat_pool))

      assert show_live
             |> form("#fiat_pool-form", fiat_pool: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#fiat_pool-form", fiat_pool: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fiat_pool_show_path(conn, :show, fiat_pool))

      assert html =~ "Fiat pool updated successfully"
    end
  end
end

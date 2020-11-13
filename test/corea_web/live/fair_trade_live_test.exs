defmodule CoreaWeb.FairTradeLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.FairTrades

  @create_attrs %{fair?: true}
  @update_attrs %{fair?: false}
  @invalid_attrs %{fair?: nil}

  defp fixture(:fair_trade) do
    {:ok, fair_trade} = FairTrades.create_fair_trade(@create_attrs)
    fair_trade
  end

  defp create_fair_trade(_) do
    fair_trade = fixture(:fair_trade)
    %{fair_trade: fair_trade}
  end

  describe "Index" do
    setup [:create_fair_trade]

    test "lists all fair_trades", %{conn: conn, fair_trade: fair_trade} do
      {:ok, _index_live, html} = live(conn, Routes.fair_trade_index_path(conn, :index))

      assert html =~ "Listing Fair trades"
    end

    test "saves new fair_trade", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.fair_trade_index_path(conn, :index))

      assert index_live |> element("a", "New Fair trade") |> render_click() =~
               "New Fair trade"

      assert_patch(index_live, Routes.fair_trade_index_path(conn, :new))

      assert index_live
             |> form("#fair_trade-form", fair_trade: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fair_trade-form", fair_trade: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fair_trade_index_path(conn, :index))

      assert html =~ "Fair trade created successfully"
    end

    test "updates fair_trade in listing", %{conn: conn, fair_trade: fair_trade} do
      {:ok, index_live, _html} = live(conn, Routes.fair_trade_index_path(conn, :index))

      assert index_live |> element("#fair_trade-#{fair_trade.id} a", "Edit") |> render_click() =~
               "Edit Fair trade"

      assert_patch(index_live, Routes.fair_trade_index_path(conn, :edit, fair_trade))

      assert index_live
             |> form("#fair_trade-form", fair_trade: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#fair_trade-form", fair_trade: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fair_trade_index_path(conn, :index))

      assert html =~ "Fair trade updated successfully"
    end

    test "deletes fair_trade in listing", %{conn: conn, fair_trade: fair_trade} do
      {:ok, index_live, _html} = live(conn, Routes.fair_trade_index_path(conn, :index))

      assert index_live |> element("#fair_trade-#{fair_trade.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fair_trade-#{fair_trade.id}")
    end
  end

  describe "Show" do
    setup [:create_fair_trade]

    test "displays fair_trade", %{conn: conn, fair_trade: fair_trade} do
      {:ok, _show_live, html} = live(conn, Routes.fair_trade_show_path(conn, :show, fair_trade))

      assert html =~ "Show Fair trade"
    end

    test "updates fair_trade within modal", %{conn: conn, fair_trade: fair_trade} do
      {:ok, show_live, _html} = live(conn, Routes.fair_trade_show_path(conn, :show, fair_trade))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fair trade"

      assert_patch(show_live, Routes.fair_trade_show_path(conn, :edit, fair_trade))

      assert show_live
             |> form("#fair_trade-form", fair_trade: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#fair_trade-form", fair_trade: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.fair_trade_show_path(conn, :show, fair_trade))

      assert html =~ "Fair trade updated successfully"
    end
  end
end

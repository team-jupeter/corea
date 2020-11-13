defmodule CoreaWeb.TxnLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Txns

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp fixture(:txn) do
    {:ok, txn} = Txns.create_txn(@create_attrs)
    txn
  end

  defp create_txn(_) do
    txn = fixture(:txn)
    %{txn: txn}
  end

  describe "Index" do
    setup [:create_txn]

    test "lists all txns", %{conn: conn, txn: txn} do
      {:ok, _index_live, html} = live(conn, Routes.txn_index_path(conn, :index))

      assert html =~ "Listing Txns"
      assert html =~ txn.type
    end

    test "saves new txn", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.txn_index_path(conn, :index))

      assert index_live |> element("a", "New Txn") |> render_click() =~
               "New Txn"

      assert_patch(index_live, Routes.txn_index_path(conn, :new))

      assert index_live
             |> form("#txn-form", txn: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#txn-form", txn: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.txn_index_path(conn, :index))

      assert html =~ "Txn created successfully"
      assert html =~ "some type"
    end

    test "updates txn in listing", %{conn: conn, txn: txn} do
      {:ok, index_live, _html} = live(conn, Routes.txn_index_path(conn, :index))

      assert index_live |> element("#txn-#{txn.id} a", "Edit") |> render_click() =~
               "Edit Txn"

      assert_patch(index_live, Routes.txn_index_path(conn, :edit, txn))

      assert index_live
             |> form("#txn-form", txn: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#txn-form", txn: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.txn_index_path(conn, :index))

      assert html =~ "Txn updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes txn in listing", %{conn: conn, txn: txn} do
      {:ok, index_live, _html} = live(conn, Routes.txn_index_path(conn, :index))

      assert index_live |> element("#txn-#{txn.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#txn-#{txn.id}")
    end
  end

  describe "Show" do
    setup [:create_txn]

    test "displays txn", %{conn: conn, txn: txn} do
      {:ok, _show_live, html} = live(conn, Routes.txn_show_path(conn, :show, txn))

      assert html =~ "Show Txn"
      assert html =~ txn.type
    end

    test "updates txn within modal", %{conn: conn, txn: txn} do
      {:ok, show_live, _html} = live(conn, Routes.txn_show_path(conn, :show, txn))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Txn"

      assert_patch(show_live, Routes.txn_show_path(conn, :edit, txn))

      assert show_live
             |> form("#txn-form", txn: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#txn-form", txn: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.txn_show_path(conn, :show, txn))

      assert html =~ "Txn updated successfully"
      assert html =~ "some updated type"
    end
  end
end

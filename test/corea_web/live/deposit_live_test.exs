defmodule CoreaWeb.DepositLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Deposits

  @create_attrs %{typel: "some typel"}
  @update_attrs %{typel: "some updated typel"}
  @invalid_attrs %{typel: nil}

  defp fixture(:deposit) do
    {:ok, deposit} = Deposits.create_deposit(@create_attrs)
    deposit
  end

  defp create_deposit(_) do
    deposit = fixture(:deposit)
    %{deposit: deposit}
  end

  describe "Index" do
    setup [:create_deposit]

    test "lists all deposits", %{conn: conn, deposit: deposit} do
      {:ok, _index_live, html} = live(conn, Routes.deposit_index_path(conn, :index))

      assert html =~ "Listing Deposits"
      assert html =~ deposit.typel
    end

    test "saves new deposit", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.deposit_index_path(conn, :index))

      assert index_live |> element("a", "New Deposit") |> render_click() =~
               "New Deposit"

      assert_patch(index_live, Routes.deposit_index_path(conn, :new))

      assert index_live
             |> form("#deposit-form", deposit: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deposit-form", deposit: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deposit_index_path(conn, :index))

      assert html =~ "Deposit created successfully"
      assert html =~ "some typel"
    end

    test "updates deposit in listing", %{conn: conn, deposit: deposit} do
      {:ok, index_live, _html} = live(conn, Routes.deposit_index_path(conn, :index))

      assert index_live |> element("#deposit-#{deposit.id} a", "Edit") |> render_click() =~
               "Edit Deposit"

      assert_patch(index_live, Routes.deposit_index_path(conn, :edit, deposit))

      assert index_live
             |> form("#deposit-form", deposit: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deposit-form", deposit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deposit_index_path(conn, :index))

      assert html =~ "Deposit updated successfully"
      assert html =~ "some updated typel"
    end

    test "deletes deposit in listing", %{conn: conn, deposit: deposit} do
      {:ok, index_live, _html} = live(conn, Routes.deposit_index_path(conn, :index))

      assert index_live |> element("#deposit-#{deposit.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#deposit-#{deposit.id}")
    end
  end

  describe "Show" do
    setup [:create_deposit]

    test "displays deposit", %{conn: conn, deposit: deposit} do
      {:ok, _show_live, html} = live(conn, Routes.deposit_show_path(conn, :show, deposit))

      assert html =~ "Show Deposit"
      assert html =~ deposit.typel
    end

    test "updates deposit within modal", %{conn: conn, deposit: deposit} do
      {:ok, show_live, _html} = live(conn, Routes.deposit_show_path(conn, :show, deposit))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deposit"

      assert_patch(show_live, Routes.deposit_show_path(conn, :edit, deposit))

      assert show_live
             |> form("#deposit-form", deposit: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#deposit-form", deposit: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deposit_show_path(conn, :show, deposit))

      assert html =~ "Deposit updated successfully"
      assert html =~ "some updated typel"
    end
  end
end

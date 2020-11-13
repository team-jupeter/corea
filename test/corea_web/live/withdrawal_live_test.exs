defmodule CoreaWeb.WithdrawalLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Withdrawals

  @create_attrs %{amount: "120.5"}
  @update_attrs %{amount: "456.7"}
  @invalid_attrs %{amount: nil}

  defp fixture(:withdrawal) do
    {:ok, withdrawal} = Withdrawals.create_withdrawal(@create_attrs)
    withdrawal
  end

  defp create_withdrawal(_) do
    withdrawal = fixture(:withdrawal)
    %{withdrawal: withdrawal}
  end

  describe "Index" do
    setup [:create_withdrawal]

    test "lists all withdrawals", %{conn: conn, withdrawal: withdrawal} do
      {:ok, _index_live, html} = live(conn, Routes.withdrawal_index_path(conn, :index))

      assert html =~ "Listing Withdrawals"
    end

    test "saves new withdrawal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.withdrawal_index_path(conn, :index))

      assert index_live |> element("a", "New Withdrawal") |> render_click() =~
               "New Withdrawal"

      assert_patch(index_live, Routes.withdrawal_index_path(conn, :new))

      assert index_live
             |> form("#withdrawal-form", withdrawal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#withdrawal-form", withdrawal: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.withdrawal_index_path(conn, :index))

      assert html =~ "Withdrawal created successfully"
    end

    test "updates withdrawal in listing", %{conn: conn, withdrawal: withdrawal} do
      {:ok, index_live, _html} = live(conn, Routes.withdrawal_index_path(conn, :index))

      assert index_live |> element("#withdrawal-#{withdrawal.id} a", "Edit") |> render_click() =~
               "Edit Withdrawal"

      assert_patch(index_live, Routes.withdrawal_index_path(conn, :edit, withdrawal))

      assert index_live
             |> form("#withdrawal-form", withdrawal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#withdrawal-form", withdrawal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.withdrawal_index_path(conn, :index))

      assert html =~ "Withdrawal updated successfully"
    end

    test "deletes withdrawal in listing", %{conn: conn, withdrawal: withdrawal} do
      {:ok, index_live, _html} = live(conn, Routes.withdrawal_index_path(conn, :index))

      assert index_live |> element("#withdrawal-#{withdrawal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#withdrawal-#{withdrawal.id}")
    end
  end

  describe "Show" do
    setup [:create_withdrawal]

    test "displays withdrawal", %{conn: conn, withdrawal: withdrawal} do
      {:ok, _show_live, html} = live(conn, Routes.withdrawal_show_path(conn, :show, withdrawal))

      assert html =~ "Show Withdrawal"
    end

    test "updates withdrawal within modal", %{conn: conn, withdrawal: withdrawal} do
      {:ok, show_live, _html} = live(conn, Routes.withdrawal_show_path(conn, :show, withdrawal))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Withdrawal"

      assert_patch(show_live, Routes.withdrawal_show_path(conn, :edit, withdrawal))

      assert show_live
             |> form("#withdrawal-form", withdrawal: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#withdrawal-form", withdrawal: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.withdrawal_show_path(conn, :show, withdrawal))

      assert html =~ "Withdrawal updated successfully"
    end
  end
end

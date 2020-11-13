defmodule CoreaWeb.AccountBookLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.AccountBooks

  @create_attrs %{monetary_unit: "some monetary_unit"}
  @update_attrs %{monetary_unit: "some updated monetary_unit"}
  @invalid_attrs %{monetary_unit: nil}

  defp fixture(:account_book) do
    {:ok, account_book} = AccountBooks.create_account_book(@create_attrs)
    account_book
  end

  defp create_account_book(_) do
    account_book = fixture(:account_book)
    %{account_book: account_book}
  end

  describe "Index" do
    setup [:create_account_book]

    test "lists all account_books", %{conn: conn, account_book: account_book} do
      {:ok, _index_live, html} = live(conn, Routes.account_book_index_path(conn, :index))

      assert html =~ "Listing Account books"
      assert html =~ account_book.monetary_unit
    end

    test "saves new account_book", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.account_book_index_path(conn, :index))

      assert index_live |> element("a", "New Account book") |> render_click() =~
               "New Account book"

      assert_patch(index_live, Routes.account_book_index_path(conn, :new))

      assert index_live
             |> form("#account_book-form", account_book: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#account_book-form", account_book: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.account_book_index_path(conn, :index))

      assert html =~ "Account book created successfully"
      assert html =~ "some monetary_unit"
    end

    test "updates account_book in listing", %{conn: conn, account_book: account_book} do
      {:ok, index_live, _html} = live(conn, Routes.account_book_index_path(conn, :index))

      assert index_live |> element("#account_book-#{account_book.id} a", "Edit") |> render_click() =~
               "Edit Account book"

      assert_patch(index_live, Routes.account_book_index_path(conn, :edit, account_book))

      assert index_live
             |> form("#account_book-form", account_book: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#account_book-form", account_book: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.account_book_index_path(conn, :index))

      assert html =~ "Account book updated successfully"
      assert html =~ "some updated monetary_unit"
    end

    test "deletes account_book in listing", %{conn: conn, account_book: account_book} do
      {:ok, index_live, _html} = live(conn, Routes.account_book_index_path(conn, :index))

      assert index_live |> element("#account_book-#{account_book.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#account_book-#{account_book.id}")
    end
  end

  describe "Show" do
    setup [:create_account_book]

    test "displays account_book", %{conn: conn, account_book: account_book} do
      {:ok, _show_live, html} = live(conn, Routes.account_book_show_path(conn, :show, account_book))

      assert html =~ "Show Account book"
      assert html =~ account_book.monetary_unit
    end

    test "updates account_book within modal", %{conn: conn, account_book: account_book} do
      {:ok, show_live, _html} = live(conn, Routes.account_book_show_path(conn, :show, account_book))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Account book"

      assert_patch(show_live, Routes.account_book_show_path(conn, :edit, account_book))

      assert show_live
             |> form("#account_book-form", account_book: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#account_book-form", account_book: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.account_book_show_path(conn, :show, account_book))

      assert html =~ "Account book updated successfully"
      assert html =~ "some updated monetary_unit"
    end
  end
end

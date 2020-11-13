defmodule CoreaWeb.TaxationLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Taxations

  @create_attrs %{auth_code: "some auth_code", name: "some name", t1_balance: "120.5", telephones: [], unique_digits: "some unique_digits"}
  @update_attrs %{auth_code: "some updated auth_code", name: "some updated name", t1_balance: "456.7", telephones: [], unique_digits: "some updated unique_digits"}
  @invalid_attrs %{auth_code: nil, name: nil, t1_balance: nil, telephones: nil, unique_digits: nil}

  defp fixture(:taxation) do
    {:ok, taxation} = Taxations.create_taxation(@create_attrs)
    taxation
  end

  defp create_taxation(_) do
    taxation = fixture(:taxation)
    %{taxation: taxation}
  end

  describe "Index" do
    setup [:create_taxation]

    test "lists all taxations", %{conn: conn, taxation: taxation} do
      {:ok, _index_live, html} = live(conn, Routes.taxation_index_path(conn, :index))

      assert html =~ "Listing Taxations"
      assert html =~ taxation.auth_code
    end

    test "saves new taxation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.taxation_index_path(conn, :index))

      assert index_live |> element("a", "New Taxation") |> render_click() =~
               "New Taxation"

      assert_patch(index_live, Routes.taxation_index_path(conn, :new))

      assert index_live
             |> form("#taxation-form", taxation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#taxation-form", taxation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.taxation_index_path(conn, :index))

      assert html =~ "Taxation created successfully"
      assert html =~ "some auth_code"
    end

    test "updates taxation in listing", %{conn: conn, taxation: taxation} do
      {:ok, index_live, _html} = live(conn, Routes.taxation_index_path(conn, :index))

      assert index_live |> element("#taxation-#{taxation.id} a", "Edit") |> render_click() =~
               "Edit Taxation"

      assert_patch(index_live, Routes.taxation_index_path(conn, :edit, taxation))

      assert index_live
             |> form("#taxation-form", taxation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#taxation-form", taxation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.taxation_index_path(conn, :index))

      assert html =~ "Taxation updated successfully"
      assert html =~ "some updated auth_code"
    end

    test "deletes taxation in listing", %{conn: conn, taxation: taxation} do
      {:ok, index_live, _html} = live(conn, Routes.taxation_index_path(conn, :index))

      assert index_live |> element("#taxation-#{taxation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#taxation-#{taxation.id}")
    end
  end

  describe "Show" do
    setup [:create_taxation]

    test "displays taxation", %{conn: conn, taxation: taxation} do
      {:ok, _show_live, html} = live(conn, Routes.taxation_show_path(conn, :show, taxation))

      assert html =~ "Show Taxation"
      assert html =~ taxation.auth_code
    end

    test "updates taxation within modal", %{conn: conn, taxation: taxation} do
      {:ok, show_live, _html} = live(conn, Routes.taxation_show_path(conn, :show, taxation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Taxation"

      assert_patch(show_live, Routes.taxation_show_path(conn, :edit, taxation))

      assert show_live
             |> form("#taxation-form", taxation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#taxation-form", taxation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.taxation_show_path(conn, :show, taxation))

      assert html =~ "Taxation updated successfully"
      assert html =~ "some updated auth_code"
    end
  end
end

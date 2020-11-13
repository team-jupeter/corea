defmodule CoreaWeb.TaxRateLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.TaxRates

  @create_attrs %{gpc_code: "some gpc_code"}
  @update_attrs %{gpc_code: "some updated gpc_code"}
  @invalid_attrs %{gpc_code: nil}

  defp fixture(:tax_rate) do
    {:ok, tax_rate} = TaxRates.create_tax_rate(@create_attrs)
    tax_rate
  end

  defp create_tax_rate(_) do
    tax_rate = fixture(:tax_rate)
    %{tax_rate: tax_rate}
  end

  describe "Index" do
    setup [:create_tax_rate]

    test "lists all tax_rates", %{conn: conn, tax_rate: tax_rate} do
      {:ok, _index_live, html} = live(conn, Routes.tax_rate_index_path(conn, :index))

      assert html =~ "Listing Tax rates"
      assert html =~ tax_rate.gpc_code
    end

    test "saves new tax_rate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.tax_rate_index_path(conn, :index))

      assert index_live |> element("a", "New Tax rate") |> render_click() =~
               "New Tax rate"

      assert_patch(index_live, Routes.tax_rate_index_path(conn, :new))

      assert index_live
             |> form("#tax_rate-form", tax_rate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tax_rate-form", tax_rate: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tax_rate_index_path(conn, :index))

      assert html =~ "Tax rate created successfully"
      assert html =~ "some gpc_code"
    end

    test "updates tax_rate in listing", %{conn: conn, tax_rate: tax_rate} do
      {:ok, index_live, _html} = live(conn, Routes.tax_rate_index_path(conn, :index))

      assert index_live |> element("#tax_rate-#{tax_rate.id} a", "Edit") |> render_click() =~
               "Edit Tax rate"

      assert_patch(index_live, Routes.tax_rate_index_path(conn, :edit, tax_rate))

      assert index_live
             |> form("#tax_rate-form", tax_rate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#tax_rate-form", tax_rate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tax_rate_index_path(conn, :index))

      assert html =~ "Tax rate updated successfully"
      assert html =~ "some updated gpc_code"
    end

    test "deletes tax_rate in listing", %{conn: conn, tax_rate: tax_rate} do
      {:ok, index_live, _html} = live(conn, Routes.tax_rate_index_path(conn, :index))

      assert index_live |> element("#tax_rate-#{tax_rate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tax_rate-#{tax_rate.id}")
    end
  end

  describe "Show" do
    setup [:create_tax_rate]

    test "displays tax_rate", %{conn: conn, tax_rate: tax_rate} do
      {:ok, _show_live, html} = live(conn, Routes.tax_rate_show_path(conn, :show, tax_rate))

      assert html =~ "Show Tax rate"
      assert html =~ tax_rate.gpc_code
    end

    test "updates tax_rate within modal", %{conn: conn, tax_rate: tax_rate} do
      {:ok, show_live, _html} = live(conn, Routes.tax_rate_show_path(conn, :show, tax_rate))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tax rate"

      assert_patch(show_live, Routes.tax_rate_show_path(conn, :edit, tax_rate))

      assert show_live
             |> form("#tax_rate-form", tax_rate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#tax_rate-form", tax_rate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.tax_rate_show_path(conn, :show, tax_rate))

      assert html =~ "Tax rate updated successfully"
      assert html =~ "some updated gpc_code"
    end
  end
end

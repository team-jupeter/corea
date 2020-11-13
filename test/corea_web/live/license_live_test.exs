defmodule CoreaWeb.LicenseLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Licenses

  @create_attrs %{issued_by: "some issued_by"}
  @update_attrs %{issued_by: "some updated issued_by"}
  @invalid_attrs %{issued_by: nil}

  defp fixture(:license) do
    {:ok, license} = Licenses.create_license(@create_attrs)
    license
  end

  defp create_license(_) do
    license = fixture(:license)
    %{license: license}
  end

  describe "Index" do
    setup [:create_license]

    test "lists all licenses", %{conn: conn, license: license} do
      {:ok, _index_live, html} = live(conn, Routes.license_index_path(conn, :index))

      assert html =~ "Listing Licenses"
      assert html =~ license.issued_by
    end

    test "saves new license", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.license_index_path(conn, :index))

      assert index_live |> element("a", "New License") |> render_click() =~
               "New License"

      assert_patch(index_live, Routes.license_index_path(conn, :new))

      assert index_live
             |> form("#license-form", license: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#license-form", license: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.license_index_path(conn, :index))

      assert html =~ "License created successfully"
      assert html =~ "some issued_by"
    end

    test "updates license in listing", %{conn: conn, license: license} do
      {:ok, index_live, _html} = live(conn, Routes.license_index_path(conn, :index))

      assert index_live |> element("#license-#{license.id} a", "Edit") |> render_click() =~
               "Edit License"

      assert_patch(index_live, Routes.license_index_path(conn, :edit, license))

      assert index_live
             |> form("#license-form", license: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#license-form", license: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.license_index_path(conn, :index))

      assert html =~ "License updated successfully"
      assert html =~ "some updated issued_by"
    end

    test "deletes license in listing", %{conn: conn, license: license} do
      {:ok, index_live, _html} = live(conn, Routes.license_index_path(conn, :index))

      assert index_live |> element("#license-#{license.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#license-#{license.id}")
    end
  end

  describe "Show" do
    setup [:create_license]

    test "displays license", %{conn: conn, license: license} do
      {:ok, _show_live, html} = live(conn, Routes.license_show_path(conn, :show, license))

      assert html =~ "Show License"
      assert html =~ license.issued_by
    end

    test "updates license within modal", %{conn: conn, license: license} do
      {:ok, show_live, _html} = live(conn, Routes.license_show_path(conn, :show, license))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit License"

      assert_patch(show_live, Routes.license_show_path(conn, :edit, license))

      assert show_live
             |> form("#license-form", license: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#license-form", license: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.license_show_path(conn, :show, license))

      assert html =~ "License updated successfully"
      assert html =~ "some updated issued_by"
    end
  end
end

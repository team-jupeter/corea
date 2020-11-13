defmodule CoreaWeb.AddressLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Addresses

  @create_attrs %{city: "some city"}
  @update_attrs %{city: "some updated city"}
  @invalid_attrs %{city: nil}

  defp fixture(:address) do
    {:ok, address} = Addresses.create_address(@create_attrs)
    address
  end

  defp create_address(_) do
    address = fixture(:address)
    %{address: address}
  end

  describe "Index" do
    setup [:create_address]

    test "lists all addresses", %{conn: conn, address: address} do
      {:ok, _index_live, html} = live(conn, Routes.address_index_path(conn, :index))

      assert html =~ "Listing Addresses"
      assert html =~ address.city
    end

    test "saves new address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.address_index_path(conn, :index))

      assert index_live |> element("a", "New Address") |> render_click() =~
               "New Address"

      assert_patch(index_live, Routes.address_index_path(conn, :new))

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#address-form", address: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.address_index_path(conn, :index))

      assert html =~ "Address created successfully"
      assert html =~ "some city"
    end

    test "updates address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, Routes.address_index_path(conn, :index))

      assert index_live |> element("#address-#{address.id} a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(index_live, Routes.address_index_path(conn, :edit, address))

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#address-form", address: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.address_index_path(conn, :index))

      assert html =~ "Address updated successfully"
      assert html =~ "some updated city"
    end

    test "deletes address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, Routes.address_index_path(conn, :index))

      assert index_live |> element("#address-#{address.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#address-#{address.id}")
    end
  end

  describe "Show" do
    setup [:create_address]

    test "displays address", %{conn: conn, address: address} do
      {:ok, _show_live, html} = live(conn, Routes.address_show_path(conn, :show, address))

      assert html =~ "Show Address"
      assert html =~ address.city
    end

    test "updates address within modal", %{conn: conn, address: address} do
      {:ok, show_live, _html} = live(conn, Routes.address_show_path(conn, :show, address))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(show_live, Routes.address_show_path(conn, :edit, address))

      assert show_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#address-form", address: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.address_show_path(conn, :show, address))

      assert html =~ "Address updated successfully"
      assert html =~ "some updated city"
    end
  end
end

defmodule CoreaWeb.FamilyLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Families

  @create_attrs %{address: "some address", auth_code: "some auth_code", family_code: "some family_code", house_holder_email: "some house_holder_email", house_holder_name: "some house_holder_name", house_holder_supul_id: "some house_holder_supul_id", nationality: "some nationality", t1_balance: "120.5"}
  @update_attrs %{address: "some updated address", auth_code: "some updated auth_code", family_code: "some updated family_code", house_holder_email: "some updated house_holder_email", house_holder_name: "some updated house_holder_name", house_holder_supul_id: "some updated house_holder_supul_id", nationality: "some updated nationality", t1_balance: "456.7"}
  @invalid_attrs %{address: nil, auth_code: nil, family_code: nil, house_holder_email: nil, house_holder_name: nil, house_holder_supul_id: nil, nationality: nil, t1_balance: nil}

  defp fixture(:family) do
    {:ok, family} = Families.create_family(@create_attrs)
    family
  end

  defp create_family(_) do
    family = fixture(:family)
    %{family: family}
  end

  describe "Index" do
    setup [:create_family]

    test "lists all families", %{conn: conn, family: family} do
      {:ok, _index_live, html} = live(conn, Routes.family_index_path(conn, :index))

      assert html =~ "Listing Families"
      assert html =~ family.address
    end

    test "saves new family", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.family_index_path(conn, :index))

      assert index_live |> element("a", "New Family") |> render_click() =~
               "New Family"

      assert_patch(index_live, Routes.family_index_path(conn, :new))

      assert index_live
             |> form("#family-form", family: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#family-form", family: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.family_index_path(conn, :index))

      assert html =~ "Family created successfully"
      assert html =~ "some address"
    end

    test "updates family in listing", %{conn: conn, family: family} do
      {:ok, index_live, _html} = live(conn, Routes.family_index_path(conn, :index))

      assert index_live |> element("#family-#{family.id} a", "Edit") |> render_click() =~
               "Edit Family"

      assert_patch(index_live, Routes.family_index_path(conn, :edit, family))

      assert index_live
             |> form("#family-form", family: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#family-form", family: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.family_index_path(conn, :index))

      assert html =~ "Family updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes family in listing", %{conn: conn, family: family} do
      {:ok, index_live, _html} = live(conn, Routes.family_index_path(conn, :index))

      assert index_live |> element("#family-#{family.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#family-#{family.id}")
    end
  end

  describe "Show" do
    setup [:create_family]

    test "displays family", %{conn: conn, family: family} do
      {:ok, _show_live, html} = live(conn, Routes.family_show_path(conn, :show, family))

      assert html =~ "Show Family"
      assert html =~ family.address
    end

    test "updates family within modal", %{conn: conn, family: family} do
      {:ok, show_live, _html} = live(conn, Routes.family_show_path(conn, :show, family))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Family"

      assert_patch(show_live, Routes.family_show_path(conn, :edit, family))

      assert show_live
             |> form("#family-form", family: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#family-form", family: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.family_show_path(conn, :show, family))

      assert html =~ "Family updated successfully"
      assert html =~ "some updated address"
    end
  end
end

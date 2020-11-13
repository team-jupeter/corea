defmodule CoreaWeb.NationLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Nations

  @create_attrs %{constitution_signature: "some constitution_signature", name: "some name"}
  @update_attrs %{constitution_signature: "some updated constitution_signature", name: "some updated name"}
  @invalid_attrs %{constitution_signature: nil, name: nil}

  defp fixture(:nation) do
    {:ok, nation} = Nations.create_nation(@create_attrs)
    nation
  end

  defp create_nation(_) do
    nation = fixture(:nation)
    %{nation: nation}
  end

  describe "Index" do
    setup [:create_nation]

    test "lists all nations", %{conn: conn, nation: nation} do
      {:ok, _index_live, html} = live(conn, Routes.nation_index_path(conn, :index))

      assert html =~ "Listing Nations"
      assert html =~ nation.constitution_signature
    end

    test "saves new nation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.nation_index_path(conn, :index))

      assert index_live |> element("a", "New Nation") |> render_click() =~
               "New Nation"

      assert_patch(index_live, Routes.nation_index_path(conn, :new))

      assert index_live
             |> form("#nation-form", nation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nation-form", nation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_index_path(conn, :index))

      assert html =~ "Nation created successfully"
      assert html =~ "some constitution_signature"
    end

    test "updates nation in listing", %{conn: conn, nation: nation} do
      {:ok, index_live, _html} = live(conn, Routes.nation_index_path(conn, :index))

      assert index_live |> element("#nation-#{nation.id} a", "Edit") |> render_click() =~
               "Edit Nation"

      assert_patch(index_live, Routes.nation_index_path(conn, :edit, nation))

      assert index_live
             |> form("#nation-form", nation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nation-form", nation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_index_path(conn, :index))

      assert html =~ "Nation updated successfully"
      assert html =~ "some updated constitution_signature"
    end

    test "deletes nation in listing", %{conn: conn, nation: nation} do
      {:ok, index_live, _html} = live(conn, Routes.nation_index_path(conn, :index))

      assert index_live |> element("#nation-#{nation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#nation-#{nation.id}")
    end
  end

  describe "Show" do
    setup [:create_nation]

    test "displays nation", %{conn: conn, nation: nation} do
      {:ok, _show_live, html} = live(conn, Routes.nation_show_path(conn, :show, nation))

      assert html =~ "Show Nation"
      assert html =~ nation.constitution_signature
    end

    test "updates nation within modal", %{conn: conn, nation: nation} do
      {:ok, show_live, _html} = live(conn, Routes.nation_show_path(conn, :show, nation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Nation"

      assert_patch(show_live, Routes.nation_show_path(conn, :edit, nation))

      assert show_live
             |> form("#nation-form", nation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#nation-form", nation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nation_show_path(conn, :show, nation))

      assert html =~ "Nation updated successfully"
      assert html =~ "some updated constitution_signature"
    end
  end
end

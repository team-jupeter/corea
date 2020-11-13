defmodule CoreaWeb.ConstitutionLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Constitutions

  @create_attrs %{content: "some content", content_hash: "some content_hash", empowered_on: ~N[2010-04-17 14:00:00], nationality: "some nationality", sighed_by: []}
  @update_attrs %{content: "some updated content", content_hash: "some updated content_hash", empowered_on: ~N[2011-05-18 15:01:01], nationality: "some updated nationality", sighed_by: []}
  @invalid_attrs %{content: nil, content_hash: nil, empowered_on: nil, nationality: nil, sighed_by: nil}

  defp fixture(:constitution) do
    {:ok, constitution} = Constitutions.create_constitution(@create_attrs)
    constitution
  end

  defp create_constitution(_) do
    constitution = fixture(:constitution)
    %{constitution: constitution}
  end

  describe "Index" do
    setup [:create_constitution]

    test "lists all constitutions", %{conn: conn, constitution: constitution} do
      {:ok, _index_live, html} = live(conn, Routes.constitution_index_path(conn, :index))

      assert html =~ "Listing Constitutions"
      assert html =~ constitution.content
    end

    test "saves new constitution", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.constitution_index_path(conn, :index))

      assert index_live |> element("a", "New Constitution") |> render_click() =~
               "New Constitution"

      assert_patch(index_live, Routes.constitution_index_path(conn, :new))

      assert index_live
             |> form("#constitution-form", constitution: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#constitution-form", constitution: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.constitution_index_path(conn, :index))

      assert html =~ "Constitution created successfully"
      assert html =~ "some content"
    end

    test "updates constitution in listing", %{conn: conn, constitution: constitution} do
      {:ok, index_live, _html} = live(conn, Routes.constitution_index_path(conn, :index))

      assert index_live |> element("#constitution-#{constitution.id} a", "Edit") |> render_click() =~
               "Edit Constitution"

      assert_patch(index_live, Routes.constitution_index_path(conn, :edit, constitution))

      assert index_live
             |> form("#constitution-form", constitution: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#constitution-form", constitution: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.constitution_index_path(conn, :index))

      assert html =~ "Constitution updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes constitution in listing", %{conn: conn, constitution: constitution} do
      {:ok, index_live, _html} = live(conn, Routes.constitution_index_path(conn, :index))

      assert index_live |> element("#constitution-#{constitution.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#constitution-#{constitution.id}")
    end
  end

  describe "Show" do
    setup [:create_constitution]

    test "displays constitution", %{conn: conn, constitution: constitution} do
      {:ok, _show_live, html} = live(conn, Routes.constitution_show_path(conn, :show, constitution))

      assert html =~ "Show Constitution"
      assert html =~ constitution.content
    end

    test "updates constitution within modal", %{conn: conn, constitution: constitution} do
      {:ok, show_live, _html} = live(conn, Routes.constitution_show_path(conn, :show, constitution))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Constitution"

      assert_patch(show_live, Routes.constitution_show_path(conn, :edit, constitution))

      assert show_live
             |> form("#constitution-form", constitution: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#constitution-form", constitution: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.constitution_show_path(conn, :show, constitution))

      assert html =~ "Constitution updated successfully"
      assert html =~ "some updated content"
    end
  end
end

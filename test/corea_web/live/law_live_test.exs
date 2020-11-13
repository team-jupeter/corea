defmodule CoreaWeb.LawLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Laws

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp fixture(:law) do
    {:ok, law} = Laws.create_law(@create_attrs)
    law
  end

  defp create_law(_) do
    law = fixture(:law)
    %{law: law}
  end

  describe "Index" do
    setup [:create_law]

    test "lists all laws", %{conn: conn, law: law} do
      {:ok, _index_live, html} = live(conn, Routes.law_index_path(conn, :index))

      assert html =~ "Listing Laws"
      assert html =~ law.type
    end

    test "saves new law", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.law_index_path(conn, :index))

      assert index_live |> element("a", "New Law") |> render_click() =~
               "New Law"

      assert_patch(index_live, Routes.law_index_path(conn, :new))

      assert index_live
             |> form("#law-form", law: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#law-form", law: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.law_index_path(conn, :index))

      assert html =~ "Law created successfully"
      assert html =~ "some type"
    end

    test "updates law in listing", %{conn: conn, law: law} do
      {:ok, index_live, _html} = live(conn, Routes.law_index_path(conn, :index))

      assert index_live |> element("#law-#{law.id} a", "Edit") |> render_click() =~
               "Edit Law"

      assert_patch(index_live, Routes.law_index_path(conn, :edit, law))

      assert index_live
             |> form("#law-form", law: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#law-form", law: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.law_index_path(conn, :index))

      assert html =~ "Law updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes law in listing", %{conn: conn, law: law} do
      {:ok, index_live, _html} = live(conn, Routes.law_index_path(conn, :index))

      assert index_live |> element("#law-#{law.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#law-#{law.id}")
    end
  end

  describe "Show" do
    setup [:create_law]

    test "displays law", %{conn: conn, law: law} do
      {:ok, _show_live, html} = live(conn, Routes.law_show_path(conn, :show, law))

      assert html =~ "Show Law"
      assert html =~ law.type
    end

    test "updates law within modal", %{conn: conn, law: law} do
      {:ok, show_live, _html} = live(conn, Routes.law_show_path(conn, :show, law))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Law"

      assert_patch(show_live, Routes.law_show_path(conn, :edit, law))

      assert show_live
             |> form("#law-form", law: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#law-form", law: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.law_show_path(conn, :show, law))

      assert html =~ "Law updated successfully"
      assert html =~ "some updated type"
    end
  end
end

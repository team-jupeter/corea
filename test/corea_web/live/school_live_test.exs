defmodule CoreaWeb.SchoolLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Schools

  @create_attrs %{description: "some description", mentors: [], title: "some title"}
  @update_attrs %{description: "some updated description", mentors: [], title: "some updated title"}
  @invalid_attrs %{description: nil, mentors: nil, title: nil}

  defp fixture(:school) do
    {:ok, school} = Schools.create_school(@create_attrs)
    school
  end

  defp create_school(_) do
    school = fixture(:school)
    %{school: school}
  end

  describe "Index" do
    setup [:create_school]

    test "lists all schools", %{conn: conn, school: school} do
      {:ok, _index_live, html} = live(conn, Routes.school_index_path(conn, :index))

      assert html =~ "Listing Schools"
      assert html =~ school.description
    end

    test "saves new school", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.school_index_path(conn, :index))

      assert index_live |> element("a", "New School") |> render_click() =~
               "New School"

      assert_patch(index_live, Routes.school_index_path(conn, :new))

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#school-form", school: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.school_index_path(conn, :index))

      assert html =~ "School created successfully"
      assert html =~ "some description"
    end

    test "updates school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, Routes.school_index_path(conn, :index))

      assert index_live |> element("#school-#{school.id} a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(index_live, Routes.school_index_path(conn, :edit, school))

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#school-form", school: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.school_index_path(conn, :index))

      assert html =~ "School updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, Routes.school_index_path(conn, :index))

      assert index_live |> element("#school-#{school.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#school-#{school.id}")
    end
  end

  describe "Show" do
    setup [:create_school]

    test "displays school", %{conn: conn, school: school} do
      {:ok, _show_live, html} = live(conn, Routes.school_show_path(conn, :show, school))

      assert html =~ "Show School"
      assert html =~ school.description
    end

    test "updates school within modal", %{conn: conn, school: school} do
      {:ok, show_live, _html} = live(conn, Routes.school_show_path(conn, :show, school))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(show_live, Routes.school_show_path(conn, :edit, school))

      assert show_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#school-form", school: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.school_show_path(conn, :show, school))

      assert html =~ "School updated successfully"
      assert html =~ "some updated description"
    end
  end
end

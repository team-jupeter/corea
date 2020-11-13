defmodule CoreaWeb.CourseLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Courses

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:course) do
    {:ok, course} = Courses.create_course(@create_attrs)
    course
  end

  defp create_course(_) do
    course = fixture(:course)
    %{course: course}
  end

  describe "Index" do
    setup [:create_course]

    test "lists all courses", %{conn: conn, course: course} do
      {:ok, _index_live, html} = live(conn, Routes.course_index_path(conn, :index))

      assert html =~ "Listing Courses"
      assert html =~ course.title
    end

    test "saves new course", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.course_index_path(conn, :index))

      assert index_live |> element("a", "New Course") |> render_click() =~
               "New Course"

      assert_patch(index_live, Routes.course_index_path(conn, :new))

      assert index_live
             |> form("#course-form", course: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#course-form", course: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.course_index_path(conn, :index))

      assert html =~ "Course created successfully"
      assert html =~ "some title"
    end

    test "updates course in listing", %{conn: conn, course: course} do
      {:ok, index_live, _html} = live(conn, Routes.course_index_path(conn, :index))

      assert index_live |> element("#course-#{course.id} a", "Edit") |> render_click() =~
               "Edit Course"

      assert_patch(index_live, Routes.course_index_path(conn, :edit, course))

      assert index_live
             |> form("#course-form", course: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#course-form", course: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.course_index_path(conn, :index))

      assert html =~ "Course updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes course in listing", %{conn: conn, course: course} do
      {:ok, index_live, _html} = live(conn, Routes.course_index_path(conn, :index))

      assert index_live |> element("#course-#{course.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#course-#{course.id}")
    end
  end

  describe "Show" do
    setup [:create_course]

    test "displays course", %{conn: conn, course: course} do
      {:ok, _show_live, html} = live(conn, Routes.course_show_path(conn, :show, course))

      assert html =~ "Show Course"
      assert html =~ course.title
    end

    test "updates course within modal", %{conn: conn, course: course} do
      {:ok, show_live, _html} = live(conn, Routes.course_show_path(conn, :show, course))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Course"

      assert_patch(show_live, Routes.course_show_path(conn, :edit, course))

      assert show_live
             |> form("#course-form", course: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#course-form", course: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.course_show_path(conn, :show, course))

      assert html =~ "Course updated successfully"
      assert html =~ "some updated title"
    end
  end
end
